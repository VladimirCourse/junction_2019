class RecommendationsController < ApplicationController

    # GET /recommendations
    def index
        # magical recommendation system
        render json: [
            {
                name: 'Breakfast',
                places: [
                    {
                        place: Place.all.first,
                        dishes: Place.all.first.dishes
                    }
                ],
            },
            {
                name: 'Lunch',
                places: [
                    {
                        place: Place.all.second,
                        dishes: Place.all.second.dishes
                    }
                ],
            },
            {
                name: 'Dinner',
                places: [
                    {
                        place: Place.all.third,
                        dishes: Place.all.third.dishes
                    }
                ],
            }
        ]
    end
end
