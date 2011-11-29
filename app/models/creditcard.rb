class Creditcard < ActiveRecord::Base

  attr_accessor :cvv, :month, :year, :number, :amcard

  before_validation :set_card_type,               on: :create
  before_validation :strip_non_numeric_values,    on: :create

  validate :validation_by_active_merchant,        on: :create

  before_create :set_masked_number, :set_expires_on

  alias :verification_value :cvv # ActiveMerchant needs this

  def verification_value?
    true # ActiveMerchant needs this
  end

  private

  def strip_non_numeric_values
    self.number = self.number.gsub(/[^\d]/, '') if self.number
  end

  def set_card_type
    self.card_type = ActiveMerchant::Billing::CreditCard.type?(number)
  end

  def validation_by_active_merchant
    self.amcard = ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => number,
      :verification_value => verification_value,
      :month              => month,
      :year               => year,
      :first_name         => first_name,
      :last_name          => last_name)
    unless self.amcard.valid?
      self.amcard.errors.full_messages.each { |message| self.errors.add(:base, message) }
    end
  end

  def set_masked_number
    self.masked_number = self.amcard.display_number
  end

  def set_expires_on
    self.expires_on = Time.zone.parse("#{month}-01-#{year}").end_of_month
  end

end
