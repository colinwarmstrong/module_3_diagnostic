class SearchController < ApplicationController
  def index
    @stations = StationsSearch.new.ten_closest_stations(params[:q])
    binding.pry
  end
end
