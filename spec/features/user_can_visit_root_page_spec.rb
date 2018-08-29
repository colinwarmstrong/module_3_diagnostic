require 'rails_helper'

feature "User can visit root page" do
  scenario "and view navbar contents" do
    visit "/"
    within(".navbar") do
      expect(page).to have_content("AltFuelFinder")
      expect(page).to have_selector("input[value='Search by zip...']")
    end
  end

  it 'they can search for a list of the ten closest stations sorted by distance within 6 miles' do
    # As a user
    # When I visit "/"
    visit root_path
    # And I fill in the search form with 80203 (Note: Use the existing search form)
    fill_in :q, with: '80203'
    # And I click "Locate"
    click_on 'Locate'
    # Then I should be on page "/search"
    expect(current_path).to eq(search_path)
    # Then I should see a list of the 10 closest stations within 6 miles sorted by distance
    # And the stations should be limited to Electric and Propane
    expect(page).to have_css('.station', count: 10)
    # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
    within(first('.station')) do
      expect(page).to have_content('Station Name: 1800 Larimer')
      expect(page).to have_content('Address: 1800 Larimer Street, Suite 1800')
      expect(page).to have_content('Fuel Type: Electric')
      expect(page).to have_content('Distance: 0.14269 miles')
      expect(page).to have_content('Access Times: MO: 12:00am-12:00am; TU: 12:00am-12:00am; WE: 12:00am-12:00am; TH: 12:00am-12:00am; FR: 12:00am-12:00am; SA: 12:00am-12:00am; SU: 12:00am-12:00am')
    end
  end
end