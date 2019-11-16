class Dish {
  
  final String id;
  final String name;
  final String description;
  final String imageId;
  final String restaurantId;
  final String currency;
  final String components;

  final double price;
  final double salePrice;
  final int calories;
  final int proteins;
  final int fats;
  final int carbohydrates;

  final List<String> categories;

  Dish(
    {
      this.id, 
      this.name, 
      this.description, 
      this.price, 
      this.salePrice,
      this.imageId,
      this.calories, 
      this.restaurantId, 
      this.currency,
      this.fats,
      this.carbohydrates,
      this.proteins,
      this.components,
      this.categories = const []
    }
  );

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      imageId: json['image_id'],
      price: json['price'] / 100.0,
      salePrice: json['sale_price'] != null ? json['sale_price'] / 100 : json['price'] / 100,
      calories: json['calories'],
      proteins: json['proteins'],
      fats: json['fats'],
      carbohydrates: json['carbohydrates'],
      restaurantId: json['restaurant_id'],
      currency: json['currency'],
      components: json['components'],
      categories:  List<String>.from(json['categories']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'image_id' : imageId,
      'price': price,
      'calories': calories,
      'restaurant_id': restaurantId,
      'currency': currency,
      'categories': categories
    };
  }

  @override 
  int get hashCode => id.hashCode;

  bool operator ==(o) => o is Dish && o.id == id;

}