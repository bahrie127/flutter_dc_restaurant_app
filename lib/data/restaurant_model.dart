import 'dart:convert';

class RestaurantModel {
  RestaurantModel({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool? error;
  String? message;
  int? count;
  List<Restaurant>? restaurants;

  factory RestaurantModel.fromRawJson(String str) =>
      RestaurantModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map(
                  (x) => Restaurant.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
