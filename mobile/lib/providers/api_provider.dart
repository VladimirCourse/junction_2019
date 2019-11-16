import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/recommendation.dart';

import '../models/place.dart';
import '../models/recommendation.dart';
import '../models/order.dart';
import '../models/order_dish.dart';

class ApiProvider { 

  //static const String url = 'http://10.84.110.246:3000';
  static const String url = 'http://34.90.110.227:3002';
  

  static const String recommendations = '/recommendations';

  static const String statistic = '/statistic';

  static const String places = '/places';

  static const String orders = '/orders';

  static final ApiProvider _singleton = ApiProvider._internal();

  Map<String, String> defaultHeader = {
    'Content-type' : 'application/json', 
  };

  ApiProvider._internal();

  factory ApiProvider() {
    return _singleton;
  }

  String queryParams(Map<String, dynamic> params){
    String queryParams = '';
    if (params != null && params.isNotEmpty){
      queryParams = '?';

      for (final param in params.keys){
        final val = params[param];
        if (val != null){
          if (val is List<String>){
            for (final arr in val){
              queryParams += '$param%5B%5D=$arr&';
            }
          } else {
            queryParams += '$param=$val&';
          }
        }
      }
    }
    return queryParams;
  }


  Future<http.Response> basePostRequest(String method, {String body, Map<String, dynamic> params}) async {
    return await http.post(url + method + queryParams(params), body: body, headers: defaultHeader);
  }

  Future<http.Response> basePutRequest(String method, {String body, Map<String, dynamic> params}) async {
    return await http.put(url + method + queryParams(params), body: body, headers: defaultHeader);
  }

  Future<http.Response> baseGetRequest(String method, {Map<String, dynamic> params}) async {
    return await http.get(url + method + queryParams(params), headers: defaultHeader);
  }

  Future<http.Response> baseDeleteRequest(String method, {Map<String, dynamic> params}) async {
    return await http.delete(url + method + queryParams(params), headers: defaultHeader);
  }

  Future<T> singlePostRequest<T>(String request, Function(Map<String, dynamic>) fromJson, {Map<String, dynamic> body = const {}}) async {
    try {
      final res = await basePostRequest(request, body: json.encode(body));
      if (res.statusCode == HttpStatus.ok){
        final body = json.decode(res.body);
        return fromJson(body);
      }
    } catch (ex) {
      print(ex);
    }
  }

   Future<T> singleGetRequest<T>(String request, Function(Map<String, dynamic>) fromJson, {Map<String, dynamic> params = const {}}) async {
    try {
      final res = await baseGetRequest(request, params: params);
      if (res.statusCode == HttpStatus.ok){
        final body = json.decode(res.body);
        return fromJson(body);
      }
    } catch (ex) {
    }
  }

  Future<List<T>> listGetRequest<T>(String request, Function(Map<String, dynamic>) fromJson, {Map<String, dynamic> params = const {}}) async {
    try {
      final res = await baseGetRequest(request, params: params);
      if (res.statusCode == HttpStatus.ok){
        List body = json.decode(res.body);
        List<T> result = [];
        for (final res in body) {
          try {
            result.add(fromJson(res));
          } catch (ex) {
            print(ex);
          }
        }
        return result;
      } else {
        return [];
      }
    } catch (ex) {
      return [];
    }
  }

  void setToken(String token) {
    defaultHeader['Authorization'] = token;
  }


  Future<List<Place>> getPlaces({double lat, double lng, List<String> categories, List<String> cuisines}) async {
    return await listGetRequest<Place>(places, (p) => Place.fromJson(p),
      params: {
        'lat': lat,
        'lng': lng,
        'pcategories': categories,
        'cuisines': cuisines,
      }
    );
  }

  Future<Order> createOrder(String placeId, DateTime serveAt, String table, String takeOption, List<OrderDish> orderDishes) async {
    return await singlePostRequest<Order>(orders, 
      (u) => Order.fromJson(u), 
      body: {
        'take_option': takeOption,
        'serve_at': serveAt.toUtc().toString(),
        'place_id': placeId,
        'table': table,
        'order_dishes': orderDishes.map((o) => o.toJson()).toList()
      }
    );
  }
  
  Future<List<Order>> getOrders() async {
    return await listGetRequest<Order>(orders, (p) => Order.fromJson(p));
  }

  Future<List<Recommendations>> getRecommendations() async {
    return await listGetRequest<Recommendations>(recommendations, (p) => Recommendations.fromJson(p));
  }
}