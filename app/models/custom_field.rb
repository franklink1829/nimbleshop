class CustomField < ActiveRecord::Base

  has_many :custom_field_answers

  validates :field_type, presence: true, inclusion: { :in => %w(text number date) }
  validates :name, presence: true
end
