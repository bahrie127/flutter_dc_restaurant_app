part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Restaurant> restaurants;
  const FavoritesLoaded({
    required this.restaurants,
  });

  @override
  List<Object> get props => [restaurants];
}

class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
