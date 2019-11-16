import 'dish.dart';

class OrderDish extends Dish {
  
  final String dishId;
  final int count;
  //final Set<User> users;

  OrderDish(
    {
      String name,
      String currency,
      double price,
      double salePrice,
      int calories, 
      int fats,
      int carbohydrates,
      int proteins,
      this.dishId,
      this.count,
      //this.users
    }
  ) : 
  super(
    name: name, 
    price: price, 
    salePrice: salePrice,
    currency: currency,
    calories: calories,
    fats: fats,
    proteins: proteins,
    carbohydrates: carbohydrates
  );

  factory OrderDish.fromJson(Map<String, dynamic> json) {
    return OrderDish(
      name: json['name'],
      price: json['price'] / 100.0,
      salePrice: json['sale_price'] != null ? json['sale_price'] / 100 : json['price'] / 100,
      count: json['count'],
      calories: json['calories'],
      proteins: json['proteins'],
      fats: json['fats'],
      carbohydrates: json['carbohydrates'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'dish_id': dishId,
      'count': count
    };
  }

}