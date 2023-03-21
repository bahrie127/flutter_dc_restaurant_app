import 'dart:convert';

import 'package:flutter_dicoding_restaurant_app/data/restaurant_detail_model.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_search_model.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  Future<RestaurantModel> getListRestaurant() async {
    final response =
        await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
    if (response.statusCode == 200) {
      return RestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  Future<RestaurantDetailModel> getDetailRestaurant(String id) async {
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  Future<RestaurantSearchModel> getSearchRestaurant(String query) async {
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantSearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }
}
