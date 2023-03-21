import 'dart:convert';

import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';

class RestaurantSearchModel {
  RestaurantSearchModel({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool? error;
  int? founded;
  List<Restaurant>? restaurants;

  factory RestaurantSearchModel.fromRawJson(String str) =>
      RestaurantSearchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearchModel.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchModel(
        error: json["error"],
        founded: json["founded"],
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
        "founded": founded,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

