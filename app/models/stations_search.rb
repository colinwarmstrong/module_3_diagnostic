class StationsSearch
  def initialize
    @conn = establish_connection
  end

  def establish_connection
    Faraday.new(url: 'https://developer.nrel.gov/api/') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def call(zip_code)
    @conn.get("alt-fuel-stations/v1/nearest.json?api_key=LhAIm93PCQmmy2E5R0DMRwdctwa1UW0YuvmXlDmD&location=#{zip_code}&radius=6.0&fuel_type=ELEC, LPG")
  end

  def parse_json(zip_code)
    JSON.parse(call(zip_code).body, symbolize_names: true)
  end

  def ten_closest_stations(zip_code)
    response = parse_json(zip_code)
    response[:fuel_stations].shift(10)
  end
end
