require "application_system_test_case"

class SelfiesTest < ApplicationSystemTestCase
  setup do
    @selfy = selfies(:one)
  end

  test "visiting the index" do
    visit selfies_url
    assert_selector "h1", text: "Selfies"
  end

  test "creating a Selfie" do
    visit selfies_url
    click_on "New Selfie"

    fill_in "Title", with: @selfy.title
    click_on "Create Selfie"

    assert_text "Selfie was successfully created"
    click_on "Back"
  end

  test "updating a Selfie" do
    visit selfies_url
    click_on "Edit", match: :first

    fill_in "Title", with: @selfy.title
    click_on "Update Selfie"

    assert_text "Selfie was successfully updated"
    click_on "Back"
  end

  test "destroying a Selfie" do
    visit selfies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Selfie was successfully destroyed"
  end
end
