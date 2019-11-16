import 'place.dart';
import 'order_dish.dart';

class PurchaseStatus {
  static const String pending = 'pending';
  static const String purchased = 'purchased';
  static const String error = 'error';
}

class TakeStatus {
  static const String waiting = 'waiting';
  static const String taken = 'taken';
}

class ReadyStatus {
  static const String cooking = 'cooking';
  static const String ready = 'ready';
}

class TakeOption {
  static const String inPlace = 'in_place';
  static const String withMe = 'with_me';
}

class Order {

  final String id;
  final String purchaseStatus;
  final String takeStatus;
  final String readyStatus;
  final String takeOption;
  final String table;

  final String comment;

  final int tips;
  final double price;
  final double salePrice;

  final DateTime serveAt;

  final Place place;
  
  final List<OrderDish> orderDishes;

  Order(
    {
      this.id, 
      this.purchaseStatus,
      this.takeStatus,
      this.readyStatus,
      this.takeOption,
      this.comment,
      this.table,
      this.tips,
      this.price,
      this.salePrice,
      this.serveAt,
      this.place,
      this.orderDishes = const []
    }
  );

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      purchaseStatus: json['purchase_status'],
      takeStatus: json['take_status'],
      readyStatus: json['ready_status'],
      takeOption: json['take_option'],
      comment: json['comment'],
      table: json['table'],
      price: json['price'] / 100.0,
      salePrice: json['sale_price'] != null ? json['sale_price'] / 100 : json['price'] / 100,
      tips: json['tips'],
      serveAt: DateTime.parse(json['serve_at']),
      place: Place.fromJson(json['place']),
      orderDishes: json['order_dishes'].map<OrderDish>((w) => OrderDish.fromJson(w)).toList(),
    );
  }
  
  Map<String, dynamic> toJson(){
    return {
      '_id': id,
      'purchase_status': purchaseStatus,
      'take_status': takeStatus,
      'ready_status': readyStatus,
      'take_option': takeOption,
      'comment': comment,
      'table': table,
      'serve_at': serveAt,
      'price': price,
      'tips': tips,
      'place': place.toJson(),
      'order_dishes': orderDishes.map((o) => o.toJson()).toList()
    };
  }

}