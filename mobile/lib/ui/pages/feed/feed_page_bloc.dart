import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../providers/api_provider.dart';

import '../../../models/dish.dart';
import '../../../models/recommendation.dart';
import '../../../models/order_dish.dart';
import '../../../models/place.dart';
import '../../../models/cart.dart';
import '../../../models/status.dart';

class FeedPageBloc {

  final api = ApiProvider();

  final status = Status();

  final recomenndations = BehaviorSubject<List<Recommendations>>();
  final chaanged = BehaviorSubject<bool>();

  void init() async {
    final res = await api.getRecommendations();
    recomenndations.sink.add(res);
  }

  void change(int index, bool value) {
    status.change(index, value);
    chaanged.sink.add(true);
  }

}