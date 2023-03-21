import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_dicoding_restaurant_app/data/db/favorites_db.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';

part 'favorite_detail_state.dart';

class FavoriteDetailCubit extends Cubit<FavoriteDetailState> {
  final FavoritesDb favoritesDb;
  FavoriteDetailCubit(
    this.favoritesDb,
  ) : super(FavoriteDetailInitial());

  void clickFavorite(Restaurant restaurant) {
    if (state is FavoriteDetailFound) {
      removeFavorite(restaurant);
    } else {
      addFavorite(restaurant);
    }
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      emit(FavoriteDetailLoading());
      await favoritesDb.addFavorite(restaurant);
      emit(const FavoriteDetailSuccess(message: 'Add Favorite successfully'));
      getFavoriteById(restaurant.id!);
    } catch (e) {
      emit(const FavoriteDetailError(message: 'General Error'));
    }
  }

  void removeFavorite(Restaurant restaurant) async {
    try {
      emit(FavoriteDetailLoading());
      await favoritesDb.deleteFavorites(restaurant.id!);
      emit(const FavoriteDetailSuccess(message: 'Remove Favorite successfully'));
      getFavoriteById(restaurant.id!);
    } catch (e) {
      emit(const FavoriteDetailError(message: 'General Error'));
    }
  }

  void getFavoriteById(String id) async {
    try {
      emit(FavoriteDetailLoading());
      final result = await favoritesDb.getFavoritesById(id);
      if (result != null) {
        emit(FavoriteDetailFound());
      } else {
        emit(FavoriteDetailNotFound());
      }
    } catch (e) {
      emit(const FavoriteDetailError(message: 'General Error'));
    }
  }
}
