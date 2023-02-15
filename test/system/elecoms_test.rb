require "application_system_test_case"

class ElecomsTest < ApplicationSystemTestCase
  setup do
    @elecom = elecoms(:one)
  end

  test "visiting the index" do
    visit elecoms_url
    assert_selector "h1", text: "Elecoms"
  end

  test "should create elecom" do
    visit elecoms_url
    click_on "New elecom"

    fill_in "Name", with: @elecom.name
    fill_in "Position", with: @elecom.position
    click_on "Create Elecom"

    assert_text "Elecom was successfully created"
    click_on "Back"
  end

  test "should update Elecom" do
    visit elecom_url(@elecom)
    click_on "Edit this elecom", match: :first

    fill_in "Name", with: @elecom.name
    fill_in "Position", with: @elecom.position
    click_on "Update Elecom"

    assert_text "Elecom was successfully updated"
    click_on "Back"
  end

  test "should destroy Elecom" do
    visit elecom_url(@elecom)
    click_on "Destroy this elecom", match: :first

    assert_text "Elecom was successfully destroyed"
  end
end
