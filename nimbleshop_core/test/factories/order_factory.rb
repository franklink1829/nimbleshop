FactoryGirl.define do
  factory :order do |f|
    email 'john@nimbleshop.com'
    shipping_address
    association :shipping_method, factory: :country_shipping_method
    sequence(:number) { |t| "xxx#{t}" }

    trait :line_items do
      after(:create) { |order| FactoryGirl.create(:line_item, order: order) }
    end

    trait :paypalwp do
      payment_method_id 2
    end

    trait :authorizedotnet do
      payment_method_id 3
    end

    trait :shipment do
      after(:create) { |order| FactoryGirl.create(:shipment, order: order) }
    end

    factory :order_with_line_items,   traits: [:line_items]

    factory :order_paid_using_paypalwp,   traits: [:paypalwp] do |order|
      order.after(:create) do |o|
        create :payment_transaction_with_paypalwp, order: o
      end
    end

    factory :order_paid_using_authorizedotnet,   traits: [:authorizedotnet, :shipment] do |order|
      order.after(:create) do |o|
        create :payment_transaction_with_authorizedotnet, order: o
      end
    end

  end
end
