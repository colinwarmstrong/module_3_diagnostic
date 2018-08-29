require 'rails_helper'

feature "User can visit root page" do
  scenario "and view navbar contents" do
    visit "/"
    within(".navbar") do
      expect(page).to have_content("AltFuelFinder")
      expect(page).to have_selector("input[value='Search by zip...']")
    end
  end

  scenario 'and search for a list of the ten closest stations sorted by distance within 6 miles' do
    json = File.read('./spec/fixtures/nearest_stations.json')

    stub_request(:get, "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=LhAIm93PCQmmy2E5R0DMRwdctwa1UW0YuvmXlDmD&fuel_type=ELEC,%20LPG&location=80203&radius=6.0")
    .to_return(status: 200, body: json, headers: {})

    visit root_path

    zip_code = '80203'

    fill_in :q, with: zip_code
    click_on 'Locate'

    expect(current_path).to eq(search_path)
    expect(page).to have_content('Search Results:')
    expect(page).to have_css('.station', count: 10)

    within(first('.station')) do
      expect(page).to have_content('Station Name: UDR')
      expect(page).to have_content('Address: 800 Acoma St')
      expect(page).to have_content('Fuel Type: ELEC')
      expect(page).to have_content('Distance: 0.31422 miles')
      expect(page).to have_content('Access Times: 24 hours daily')
    end
  end
end
