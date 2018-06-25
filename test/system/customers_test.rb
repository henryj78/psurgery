require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:one)
  end

  test "visiting the index" do
    visit customers_url
    assert_selector "h1", text: "Customers"
  end

  test "creating a Customer" do
    visit customers_url
    click_on "New Customer"

    fill_in "Address", with: @customer.address
    fill_in "Boardcertified", with: @customer.boardcertified
    fill_in "Cell Number", with: @customer.cell_number
    fill_in "City", with: @customer.city
    fill_in "Customer Url", with: @customer.customer_url
    fill_in "Deactivate", with: @customer.deactivate
    fill_in "Description", with: @customer.description
    fill_in "First Name", with: @customer.first_name
    fill_in "Last Name", with: @customer.last_name
    fill_in "Office Number", with: @customer.office_number
    fill_in "Sale", with: @customer.sale_id
    fill_in "State", with: @customer.state
    fill_in "State", with: @customer.state_id
    fill_in "Status", with: @customer.status_id
    fill_in "Validate Cus", with: @customer.validate_cus
    fill_in "Zip", with: @customer.zip
    fill_in "Zone", with: @customer.zone_id
    click_on "Create Customer"

    assert_text "Customer was successfully created"
    click_on "Back"
  end

  test "updating a Customer" do
    visit customers_url
    click_on "Edit", match: :first

    fill_in "Address", with: @customer.address
    fill_in "Boardcertified", with: @customer.boardcertified
    fill_in "Cell Number", with: @customer.cell_number
    fill_in "City", with: @customer.city
    fill_in "Customer Url", with: @customer.customer_url
    fill_in "Deactivate", with: @customer.deactivate
    fill_in "Description", with: @customer.description
    fill_in "First Name", with: @customer.first_name
    fill_in "Last Name", with: @customer.last_name
    fill_in "Office Number", with: @customer.office_number
    fill_in "Sale", with: @customer.sale_id
    fill_in "State", with: @customer.state
    fill_in "State", with: @customer.state_id
    fill_in "Status", with: @customer.status_id
    fill_in "Validate Cus", with: @customer.validate_cus
    fill_in "Zip", with: @customer.zip
    fill_in "Zone", with: @customer.zone_id
    click_on "Update Customer"

    assert_text "Customer was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer" do
    visit customers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer was successfully destroyed"
  end
end
