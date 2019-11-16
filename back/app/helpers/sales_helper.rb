class SalesHelper

    def self.calculate(place, position)
        bookings = place.bookings.where('date >= DateTime.now').length
        dist = place.distance(position) / (6 * 10000)
        pk = sum(traffic)
        
        
    end

end