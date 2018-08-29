require 'rails_helper'

describe StationsService, type: :model do
  it 'exists' do
    stations_service = StationsService.new('80202', '2.0', ['ELEC, LPG'])

    expect(stations_service).to be_a(StationsService)
  end

  describe 'Instance Methods' do
    it '#parse_json' do
      json = File.read('./spec/fixtures/nearest_stations.json')
      zip_code = '80203'
      fuel_type = 'ELEC,%20LPG'
      radius = '6.0'

      stub_request(:get, "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['API_KEY']}&fuel_type=#{fuel_type}&location=#{zip_code}&radius=#{radius}")
      .to_return(status: 200, body: json, headers: {})

      stations_service = StationsService.new('80203', '6.0', ['ELEC, LPG'])

      json = stations_service.parse_json

      expect(json).to be_a(Hash)
      expect(json).to have_key(:fuel_stations)
      expect(json[:fuel_stations]).to be_an(Array)

      station = json[:fuel_stations].first

      expect(station).to be_a(Hash)
      expect(station).to have_key(:station_name)
      expect(station).to have_key(:street_address)
      expect(station).to have_key(:fuel_type_code)
      expect(station).to have_key(:distance)
      expect(station).to have_key(:access_days_time)
    end
  end
end
