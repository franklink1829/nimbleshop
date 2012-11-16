require "test_helper"

class ProductGroupsAcceptanceTest < ActionDispatch::IntegrationTest

  def handle_js_confirm(accept=true)
    page.execute_script "window.original_confirm_function = window.confirm"
    page.execute_script "window.confirmMsg = null"
    page.execute_script "window.confirm = function(msg) { window.confirmMsg = msg; return #{!!accept}; }"
    yield
  ensure
    page.execute_script "window.confirm = window.original_confirm_function"
  end

  setup do
    create(:price_group_condition)
    create(:date_group_condition)
  end

  test "validations" do
    visit admin_product_groups_path
    click_link 'add_new_product_group'
    fill_in 'Product group name', with: ''
    click_button 'Submit'

    refute page.has_content?('Successfully updated')
    assert page.has_content?("Product group conditions value is invalid")
    assert page.has_content?("Product group conditions value can't be blank")
    assert page.has_content?("Name can't be blank")
  end

  test "add, edit and delete for product group" do
    Capybara.current_driver = :selenium
    visit admin_product_groups_path
    assert page.has_content?("Product groups")
    click_link 'add_new_product_group'

    fill_in 'Product group name', with: 'sweet candies'

    select(find(:xpath, "//*[@id='product_group_product_group_conditions_attributes_0_name']/option[@value='name']").text,
                from: 'product_group_product_group_conditions_attributes_0_name')

    select(find(:xpath, "//*[@id='product_group_product_group_conditions_attributes_0_operator']/option[@value='contains']").text,
                from: 'product_group_product_group_conditions_attributes_0_operator')

    fill_in 'product_group_product_group_conditions_attributes_0_value', with: 'candy'

    click_link 'Add'

    select(find(:xpath, "//*[@id='product_group_product_group_conditions_attributes_1_name']/option[@value='name']").text,
                from: 'product_group_product_group_conditions_attributes_1_name')

    select(find(:xpath, "//*[@id='product_group_product_group_conditions_attributes_1_operator']/option[@value='starts']").text,
                from: 'product_group_product_group_conditions_attributes_1_operator')

    fill_in 'product_group_product_group_conditions_attributes_1_value', with: 'sweet'

    click_button 'Submit'

    assert page.has_content?('Successfully updated')
    assert page.has_content?("name contains 'candy' and name starts with 'sweet'")

    click_link 'Edit'

    fill_in 'Product group name', with: 'awesome candies'
    fill_in 'product_group_product_group_conditions_attributes_0_value', with: 'awesome'

    select(find(:xpath, "//*[@id='product_group_product_group_conditions_attributes_0_operator']/option[@value='starts']").text,
                from: 'product_group_product_group_conditions_attributes_0_operator')

    #page.all(:xpath, "//a[@class='remove-condition']").first.click
    click_link 'Remove'
    click_button 'Submit'

    assert page.has_content?('Successfully updated')
    assert page.has_content?("name starts with 'awesome'")

    #https://github.com/thoughtbot/capybara-webkit/issues/109
    handle_js_confirm do
      click_link 'Delete'
    end

    refute page.has_content?("name starts with 'awesome'")
  end

end
