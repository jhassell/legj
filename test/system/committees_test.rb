require "application_system_test_case"

class CommitteesTest < ApplicationSystemTestCase
  setup do
    @committee = committees(:one)
  end

  test "visiting the index" do
    visit committees_url
    assert_selector "h1", text: "Committees"
  end

  test "creating a Committee" do
    visit committees_url
    click_on "New Committee"

    fill_in "Meeting day", with: @committee.meeting_day
    fill_in "Meeting room", with: @committee.meeting_room
    fill_in "Meeting time", with: @committee.meeting_time
    fill_in "Name", with: @committee.name
    click_on "Create Committee"

    assert_text "Committee was successfully created"
    click_on "Back"
  end

  test "updating a Committee" do
    visit committees_url
    click_on "Edit", match: :first

    fill_in "Meeting day", with: @committee.meeting_day
    fill_in "Meeting room", with: @committee.meeting_room
    fill_in "Meeting time", with: @committee.meeting_time
    fill_in "Name", with: @committee.name
    click_on "Update Committee"

    assert_text "Committee was successfully updated"
    click_on "Back"
  end

  test "destroying a Committee" do
    visit committees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Committee was successfully destroyed"
  end
end
