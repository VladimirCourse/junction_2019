import 'dish.dart';
import 'place.dart';

class RecommendType {
  static const String purchase = 'purchase';
  static const String receipt = 'receipt';
}


class Recommendation {

  final Place place;

  final List<Dish> dishes;

  Recommendation(
    {
      this.place, 
      this.dishes = const [], 
    }
  );

  static Recommendation fromJson(Map<String, dynamic> json) {
    return Recommendation(
      place: Place.fromJson(json['place']),
      dishes: json['dishes'].map<Dish>((w) => Dish.fromJson(w)).toList(),
    );
  }
}

class Recommendations {

  final String name;

  final List<Recommendation> places;

  Recommendations(
    {
      this.name,
      this.places = const [], 
    }
  );

  static Recommendations fromJson(Map<String, dynamic> json) {
    return Recommendations(
      name: json['name'],
      places: json['places'].map<Recommendation>((w) => Recommendation.fromJson(w)).toList(),
    );
  }
}