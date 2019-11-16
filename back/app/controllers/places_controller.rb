class PlacesController < ApplicationController

    def index
        render json: Place.all
    end
end
