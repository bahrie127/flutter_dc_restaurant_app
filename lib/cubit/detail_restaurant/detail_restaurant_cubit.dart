import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_detail_model.dart';

import 'package:flutter_dicoding_restaurant_app/data/restaurant_service.dart';

part 'detail_restaurant_state.dart';

class DetailRestaurantCubit extends Cubit<DetailRestaurantState> {
  final RestaurantService service;
  DetailRestaurantCubit(
    this.service,
  ) : super(DetailRestaurantInitial());

  void getDetailRestaurant(String id) async {
    try {
      emit(DetailRestaurantLoading());
      final result = await service.getDetailRestaurant(id);
      emit(DetailRestaurantLoaded(detail: result.restaurant!));
    } on Exception {
      emit(DetailRestaurantError(
          message: 'General Error, Check your connection'));
    }
  }
}
