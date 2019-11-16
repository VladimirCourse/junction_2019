import 'package:rxdart/rxdart.dart';

//import '../../../../storage/repository.dart';

import '../../../../models/place.dart';
import '../../../../models/dish.dart';
import '../../../../models/cart.dart';

class CartListPageBloc {
  final cart = Cart();
  //final repository = Repository();

  final change = BehaviorSubject<bool>();

  void update() {
    change.sink.add(true);
  }

  void clearAll() {
    cart.clearAll();
    change.sink.add(true);
    //repository.saveCart();
  }

  void clearPlace(Place place) {
    cart.clear(place);
    change.sink.add(true);
    //repository.saveCart();
  }
}
