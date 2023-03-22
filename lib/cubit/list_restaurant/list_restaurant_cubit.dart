
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_service.dart';

part 'list_restaurant_state.dart';

class ListRestaurantCubit extends Cubit<ListRestaurantState> {
  final RestaurantService service;
  ListRestaurantCubit(
    this.service,
  ) : super(ListRestaurantInitial());

  void getListRestaurant() async {
    try {
      emit(ListRestaurantLoading());
      final result = await service.getListRestaurant();
      emit(ListRestaurantLoaded(restaurants: result.restaurants!));
    } on Exception {
      emit(ListRestaurantError(message: 'General Error, Check your connection'));
    }
  }
}
