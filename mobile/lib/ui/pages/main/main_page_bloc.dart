import 'package:rxdart/rxdart.dart';

// import '../../../models/data/cart.dart';

// import '../../../storage/repository.dart';

// import '../../../models/api/order.dart';

class MainPageBloc {

  // final cart = Cart();
  // final repository = Repository();

  final cartNotify = BehaviorSubject<bool>.seeded(false);
  final ordersNotify = BehaviorSubject<bool>.seeded(false);

  final page = BehaviorSubject<int>.seeded(2);

  void update() async {
    // final orders = await repository.getOrders(takeStatus: TakeStatus.waiting);
    // ordersNotify.sink.add(orders.isNotEmpty);

    // cartNotify.sink.add(cart.restaurants().isNotEmpty);
  }

  void setPage(int index) {
    page.sink.add(index);
  }
}