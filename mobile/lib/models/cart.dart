import 'dish.dart';
import 'place.dart';

class Cart {

  final Map<Place, Map<Dish, int>> _dishes = {};

  static final Cart _singleton = Cart._internal();
  
  Cart._internal();

  factory Cart() {
    return _singleton;
  }

  Map<Dish, int> dishes(Place place) {
    if (_dishes.containsKey(place)) {
      return _dishes[place];
    } else {
      return {};
    }
  }

  Set<Place> restaurants() {
    return _dishes.keys.toSet();
  }

  void addDish(Place place, Dish dish, int count) {
    if (!_dishes.containsKey(place)) {
      _dishes[place] = {};
    }
    _dishes[place][dish] = count;
  }

  void removeDish(Place place, Dish dish) {
    if (_dishes.containsKey(place)) {
      _dishes[place].remove(dish);
      if (_dishes[place].isEmpty) {
        _dishes.remove(place);
      }
    }
  }

  void clear(Place place) {
    _dishes.remove(place);
  }

  void clearAll() {
    _dishes.clear();
  }

  double price(Place place) {
    if (_dishes.containsKey(place) && _dishes[place].isNotEmpty) {
      return _dishes[place].keys.map((d) => _dishes[place][d] * d.price).reduce((p1, p2) => p1 + p2);
    } else {
      return 0;
    }
  }

  String currency(Place place) {
    if (_dishes.containsKey(place) && _dishes[place].isNotEmpty) {
      return _dishes[place].keys.first.currency;
    }
  }

  static fromJson(Map<String, dynamic> json) {
    final cart = Cart();
    for (final value in json['dishes']) {
      final current = Map<Dish, int>();
      final place = Place.fromJson(value['place']);
      for (final d in value['dishes']) {
        final dish = Dish.fromJson(d['dish']);
        current[dish] = d['count'];
      }
      cart._dishes[place] = current;
    }
  }
  
  Map<String, dynamic> toJson(){
    final List<dynamic> result = [];
    for (final place in _dishes.keys) {
      final Map<String, dynamic> current = {
        'place': place.toJson()
      };
      final dishes = [];
      for (final dish in _dishes[place].keys) {
        dishes.add(
          {
            'dish': dish.toJson(),
            'count': _dishes[place][dish]
          }
        );
      }
      current['dishes'] = dishes;
      result.add(current);
    } 
    return {'dishes': result};
  }

}