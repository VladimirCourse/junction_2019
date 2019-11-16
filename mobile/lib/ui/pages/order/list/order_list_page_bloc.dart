import 'package:rxdart/rxdart.dart';

import '../../../../providers/api_provider.dart';

import '../../../../models/place.dart';
import '../../../../models/order.dart';

class OrderListPageBloc {
  final api = ApiProvider();

  final orders = BehaviorSubject<List<Order>>();

  void init() async {
    final res = await api.getOrders();
    orders.sink.add(res);
  }
}