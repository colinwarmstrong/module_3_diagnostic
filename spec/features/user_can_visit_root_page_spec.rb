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
    visit root_path

    fill_in :q, with: '80203'
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
