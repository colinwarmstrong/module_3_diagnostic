class StationsService
  def initialize(zip_code)
    @conn = establish_connection
    @zip_code = zip_code
  end

  def parse_json
    JSON.parse(call.body, symbolize_names: true)
  end

  private

  def establish_connection
    Faraday.new(url: 'https://developer.nrel.gov/api/') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def call
    @conn.get("alt-fuel-stations/v1/nearest.json?api_key=LhAIm93PCQmmy2E5R0DMRwdctwa1UW0YuvmXlDmD&location=#{@zip_code}&radius=6.0&fuel_type=ELEC, LPG")
  end
end
