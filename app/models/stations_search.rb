class StationsSearch
  def initialize(zip_code = '80203', radius = '6.0', fuel_types = ['ELEC, LPG'])
    @zip_code = zip_code
    @radius = radius
    @fuel_types = fuel_types
  end

  def ten_closest_stations
    service = StationsService.new(@zip_code, @radius, @fuel_types)
    response = service.parse_json
    response[:fuel_stations].shift(10)
  end
end
