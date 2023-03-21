part of 'search_restaurant_cubit.dart';

abstract class SearchRestaurantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchRestaurantInitial extends SearchRestaurantState {}

class SearchRestaurantLoading extends SearchRestaurantState {}

class SearchRestaurantNotFound extends SearchRestaurantState {}

class SearchRestaurantLoaded extends SearchRestaurantState {
  final List<Restaurant> restaurants;
  SearchRestaurantLoaded({
    required this.restaurants,
  });

  @override
  List<Object?> get props => [restaurants];
}

class SearchRestaurantError extends SearchRestaurantState {
  final String message;
  SearchRestaurantError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
