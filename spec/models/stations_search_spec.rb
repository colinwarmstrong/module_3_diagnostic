require 'rails_helper'

describe StationsSearch, type: :model do
  it 'exists' do
    stations_search = StationsSearch.new('80202', '2.0', ['ELEC, LPG'])

    expect(stations_search).to be_a(StationsSearch)
  end

  describe 'Instance Methods' do
    it '#closest_stations' do
      json = File.read('./spec/fixtures/nearest_stations.json')
      zip_code = '80203'
      fuel_type = 'ELEC,%20LPG'
      radius = '6.0'

      stub_request(:get, "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['API_KEY']}&fuel_type=#{fuel_type}&location=#{zip_code}&radius=#{radius}")
      .to_return(status: 200, body: json, headers: {})

      stations_search = StationsSearch.new('80203', '6.0', ['ELEC, LPG'])

      stations = stations_search.closest_stations
      station = stations.first

      expect(stations).to be_an(Array)
      expect(stations.count).to eq(10)

      expect(station).to be_a(Hash)
      expect(station).to have_key(:station_name)
      expect(station).to have_key(:street_address)
      expect(station).to have_key(:fuel_type_code)
      expect(station).to have_key(:distance)
      expect(station).to have_key(:access_days_time)
    end
  end
end
