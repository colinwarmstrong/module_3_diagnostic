class SearchController < ApplicationController
  def index
    search = StationsSearch.new((params[:q]))
    @stations = search.ten_closest_stations
  end
end
