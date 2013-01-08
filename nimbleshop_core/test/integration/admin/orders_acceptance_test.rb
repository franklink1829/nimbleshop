require "test_helper"

class OrdersAcceptanceTest <  ActionDispatch::IntegrationTest

  test "paying using paypalwp" do
    order = create(:order_paid_using_paypalwp, payment_status: 'purchased')

    visit admin_path
    click_link 'Orders'

    click_link order.number
    assert page.has_content?('Paypal website payments standard')
  end

  test "paying using authorize.net" do
    order = create(:order_paid_using_authorizedotnet, payment_status: 'authorized')

    visit admin_path
    click_link 'Orders'

    click_link order.number
    assert page.has_content?('Authorize.net')
    assert page.has_content?('Payment status AUTHORIZED')
  end

  test "default payment status should be abandoned" do
    order = build :order, email: nil, shipping_address: nil, shipping_method: nil
    order.save(validate: false)

    visit admin_path
    click_link 'Orders'

    assert page.has_css?('h1.ns-page-title', text: 'Orders')
    click_link Order.first.number
    assert page.has_content?('Payment status ABANDONED')
  end

  test "even if product is deleted order with line item should come up" do
    order = build :order, email: nil, shipping_address: nil, shipping_method: nil
    order.save(validate: false)

    order  =  create :order_with_line_items
    order.line_items.first.product.destroy

    visit admin_path
    click_link 'Orders'

    assert page.has_css?('h1.ns-page-title', text: 'Orders')
    click_link order.number
    assert page.has_content?('Payment status ABANDONED')
  end

end
