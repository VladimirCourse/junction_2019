import 'dish.dart';

class Hour {

  String day;
  String open;
  String close;

  Hour({this.day, this.open, this.close});

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      day: json['day'],
      open: json['open'],
      close: json['close'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'open': open,
      'close': close
    };
  }

}

class Place {

  final String id;

  final String name;
  final String imageId;
  final String address;
  final String description;
  final String phone;
  final String category;

  final double score;

  final double lat;
  final double lng;
  final int distance;

  final List<Dish> dishes;

  Place(
    {
      this.id, 
      this.name, 
      this.imageId, 
      this.address, 
      this.lat, 
      this.lng, 
      this.phone, 
      this.description, 
      this.score,
      this.category,
      this.distance,
      this.dishes = const [], 
    }
  );

  static Place fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      lat: json['lat'] ?? 0.0,
      lng: json['lng'] ?? 0.0,
      imageId: json['image_id'],
      phone: json['phone'],
      score: json['score'],
      distance: json['distance'] ?? 0,
      category: json['category'],
      dishes: json['dishes'].map<Dish>((w) => Dish.fromJson(w)).toList(),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'lat': lat,
      'lng': lng,
      'name': name,
      'description': description,
      'address': address,
      'lat': lat,
      'lng': lng,
      'image_id': imageId,
      'phone': phone,
      'score': score,
      'category': category
    };
  }

  @override 
  int get hashCode => id.hashCode;

  bool operator ==(o) => o is Place && o.id == id;
}