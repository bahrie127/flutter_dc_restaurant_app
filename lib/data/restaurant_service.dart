import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';

class RestaurantService {
  Future<RestaurantModel> readRestaurantJson() async {
    final String response =
        await rootBundle.loadString('assets/json/restaurants.json');
    return RestaurantModel.fromJson(jsonDecode(response));
  }
}
