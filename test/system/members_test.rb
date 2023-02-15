require "application_system_test_case"

class MembersTest < ApplicationSystemTestCase
  setup do
    @member = members(:one)
  end

  test "visiting the index" do
    visit members_url
    assert_selector "h1", text: "Members"
  end

  test "should create member" do
    visit members_url
    click_on "New member"

    fill_in "Area", with: @member.area
    fill_in "Description", with: @member.description
    fill_in "Event", with: @member.event_id
    fill_in "Name", with: @member.name
    fill_in "Station", with: @member.station
    fill_in "Vote date", with: @member.vote_date
    check "Voted" if @member.voted
    click_on "Create Member"

    assert_text "Member was successfully created"
    click_on "Back"
  end

  test "should update Member" do
    visit member_url(@member)
    click_on "Edit this member", match: :first

    fill_in "Area", with: @member.area
    fill_in "Description", with: @member.description
    fill_in "Event", with: @member.event_id
    fill_in "Name", with: @member.name
    fill_in "Station", with: @member.station
    fill_in "Vote date", with: @member.vote_date
    check "Voted" if @member.voted
    click_on "Update Member"

    assert_text "Member was successfully updated"
    click_on "Back"
  end

  test "should destroy Member" do
    visit member_url(@member)
    click_on "Destroy this member", match: :first

    assert_text "Member was successfully destroyed"
  end
end
