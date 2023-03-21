import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_dicoding_restaurant_app/data/db/favorites_db.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesDb favoritesDb;
  FavoritesCubit(
    this.favoritesDb,
  ) : super(FavoritesInitial());

  

  void getFavorites() async {
    try {
      emit(FavoritesLoading());
      final result = await favoritesDb.getFavorites();
      emit(FavoritesLoaded(restaurants: result));
    } catch (e) {
      emit(const FavoritesError(message: 'General Error'));
    }
  }
}
