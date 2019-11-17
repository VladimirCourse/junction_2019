class SalesHelper

    def self.calculate(place, position)
        bookings = place.bookings.where('date >= DateTime.now').length
        places = Place.near(place)
        exp = place.expire
        likes = place.likes.lenght
        disc = Place.where(discount: true).order(:d8sc_value).last
        dist = place.distance(position) / (6 * 1000)
        pk = sum(traffic) / dist
        wk = sum(weather) / dist

        return max(0, ((bookings - (pk + wk) * bookings) * (disc / places) * exp * likes)
    end

end