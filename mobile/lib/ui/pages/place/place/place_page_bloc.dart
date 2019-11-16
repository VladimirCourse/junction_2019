import 'package:rxdart/rxdart.dart';

import '../../../../models/dish.dart';
import '../../../../models/cart.dart';

class PlacePageBloc {
  final selected = BehaviorSubject<Dish>();
  final cart = Cart();
  
  void select(Dish dish) {
    selected.sink.add(dish);
  }

}