import 'package:rxdart/rxdart.dart';

import '../../../../models/dish.dart';
import '../../../../models/place.dart';
import '../../../../models/cart.dart';

class DishDialogBloc {
  final Dish dish;
  final Place place;
  final max = 10;

  final cart = Cart();
  //final repository = Repository();

  final count = BehaviorSubject<int>.seeded(1);

  DishDialogBloc(this.place, this.dish) {
    final dishes =  cart.dishes(place);
    if (dishes.containsKey(dish)) {
      this.count.sink.add(dishes[dish]);
    }
  }

  void inc() {
    final cur = count.value;
    if (cur < max) {
      count.sink.add(cur + 1);
    }
  }

  void dec() {
    final cur = count.value;
    if (cur > 0) {
      count.sink.add(cur - 1);
    }
  }

  void add() {
    if (count.value == 0) {
       cart.removeDish(place, dish);
    } else {
      cart.addDish(place, dish, count.value);
    }
  }

  void delete() {
    cart.removeDish(place, dish);
  }
}