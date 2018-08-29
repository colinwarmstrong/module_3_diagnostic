class StationsSearch
  def ten_closest_stations(zip_code)
    response = StationsService.new(zip_code).parse_json
    response[:fuel_stations].shift(10)
  end
end
