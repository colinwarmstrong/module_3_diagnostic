class SearchController < ApplicationController
  def index
    @stations = StationsSearch.new(params[:q]).closest_stations
  end
end
