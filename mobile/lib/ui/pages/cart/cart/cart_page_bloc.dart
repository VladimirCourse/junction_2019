import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../providers/api_provider.dart';

import '../../../../models/dish.dart';
import '../../../../models/order.dart';
import '../../../../models/order_dish.dart';
import '../../../../models/place.dart';
import '../../../../models/cart.dart';

class CartPageBloc {
  final Place place;

  final cart = Cart();
  
  final api = ApiProvider();

  final cartChange = BehaviorSubject<bool>();
  final date = BehaviorSubject<DateTime>();
  final takeOption = BehaviorSubject<String>.seeded(TakeOption.inPlace);

  CartPageBloc(this.place) {
    date.sink.add(DateTime.now().add(Duration(minutes: 10)));
    setDate(firstDate());
    update();
  }

  void update() {
    cartChange.sink.add(true);
  }

  void cancelSplit() {
    update();
  }

  DateTime firstDate() {
    final current = DateTime.now();
    return current;
  }

  void setTakeOption(String value) {
    takeOption.sink.add(value);
  }

  void setDate(DateTime value) {
    date.sink.add(DateTime(value.year, value.month, value.day, date.value.hour, date.value.minute));
  }

  void setTime(TimeOfDay value) {
    date.sink.add(DateTime(date.value.year, date.value.month, date.value.day, value.hour, value.minute));      
  }

  Map<Dish, OrderDish> orderDishes() {
    final dishes = Map<Dish, OrderDish>();
    for (final dish in cart.dishes(place).keys) {
      final ord = OrderDish(
        name: dish.name,
        dishId: dish.id,
        price: dish.price,
        currency: dish.currency,
        count: cart.dishes(place)[dish]
      );
      dishes[dish] = ord;
    }
    return dishes;
  }

  Future<Order> createOrder(String table) async {
    final dishes = orderDishes();
    //final split = orderSplit();
    return await api.createOrder(
      place.id, 
      date.value, 
      table,
      takeOption.value,
      dishes.values.toList()
    );
  }

  void clear() {
    cart.clear(place);
  }
}