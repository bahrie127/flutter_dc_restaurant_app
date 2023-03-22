
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';

import 'package:flutter_dicoding_restaurant_app/data/restaurant_service.dart';

part 'search_restaurant_state.dart';

class SearchRestaurantCubit extends Cubit<SearchRestaurantState> {
  final RestaurantService service;
  SearchRestaurantCubit(
    this.service,
  ) : super(SearchRestaurantInitial());

  void getSearchRestaurant(String query) async {
    try {
      emit(SearchRestaurantLoading());
      final result = await service.getSearchRestaurant(query);
      if (result.restaurants!.isEmpty) {
        emit(SearchRestaurantNotFound());
      } else {
        emit(SearchRestaurantLoaded(restaurants: result.restaurants!));
      }
    } on Exception {
      emit(SearchRestaurantError(
          message: 'General Error, Check your connection'));
    }
  }
}
