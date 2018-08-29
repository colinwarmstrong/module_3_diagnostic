class StationsService
  def initialize(zip_code, radius, fuel_types)
    @zip_code   = zip_code
    @radius     = radius
    @fuel_types = fuel_types
  end

  def parse_json
    JSON.parse(call.body, symbolize_names: true)
  end

  private

  def call
    connection.get("alt-fuel-stations/v1/nearest.json?api_key=#{ENV['API_KEY']}&location=#{@zip_code}&radius=#{@radius}&fuel_type=#{@fuel_types.join}")
  end

  def connection
    Faraday.new(url: 'https://developer.nrel.gov/api/')
  end
end
