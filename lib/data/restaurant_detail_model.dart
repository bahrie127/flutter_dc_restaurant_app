import 'dart:convert';

class RestaurantDetailModel {
  RestaurantDetailModel({
    this.error,
    this.message,
    this.restaurant,
  });

  bool? error;
  String? message;
  RestaurantDetail? restaurant;

  factory RestaurantDetailModel.fromRawJson(String str) =>
      RestaurantDetailModel.fromJson(
        json.decode(str),
      );

  String toRawJson() => json.encode(toJson());

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailModel(
        error: json["error"],
        message: json["message"],
        restaurant: json["restaurant"] == null
            ? null
            : RestaurantDetail.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant?.toJson(),
      };
}

class RestaurantDetail {
  RestaurantDetail({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Category>? categories;
  Menus? menus;
  double? rating;
  List<CustomerReview>? customerReviews;

  factory RestaurantDetail.fromRawJson(String str) =>
      RestaurantDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x)),
              ),
        menus: json["menus"] == null
            ? null
            : Menus.fromJson(
                json["menus"],
              ),
        rating: json["rating"]?.toDouble(),
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(
                json["customerReviews"]!.map(
                  (x) => CustomerReview.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "menus": menus?.toJson(),
        "rating": rating,
        "customerReviews": customerReviews == null
            ? []
            : List<dynamic>.from(
                customerReviews!.map((x) => x.toJson()),
              ),
      };
}

class Category {
  Category({
    this.name,
  });

  String? name;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReview {
  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  String? name;
  String? review;
  String? date;

  factory CustomerReview.fromRawJson(String str) =>
      CustomerReview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerReview.fromJson(
    Map<String, dynamic> json,
  ) =>
      CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Category>? foods;
  List<Category>? drinks;

  factory Menus.fromRawJson(String str) => Menus.fromJson(
        json.decode(str),
      );

  String toRawJson() => json.encode(toJson());

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null
            ? []
            : List<Category>.from(
                json["foods"]!.map((x) => Category.fromJson(x)),
              ),
        drinks: json["drinks"] == null
            ? []
            : List<Category>.from(
                json["drinks"]!.map((x) => Category.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "foods": foods == null
            ? []
            : List<dynamic>.from(
                foods!.map((x) => x.toJson()),
              ),
        "drinks": drinks == null
            ? []
            : List<dynamic>.from(
                drinks!.map((x) => x.toJson()),
              ),
      };
}
