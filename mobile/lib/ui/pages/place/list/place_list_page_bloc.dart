import 'package:rxdart/rxdart.dart';

import '../../../../providers/api_provider.dart';
import '../../../../models/place.dart';

class PlaceListPageBloc {
  final places = BehaviorSubject<List<Place>>();

  final provider = ApiProvider();

  void init() async {
    final res = await provider.getPlaces();
    places.sink.add(res);
  }

}