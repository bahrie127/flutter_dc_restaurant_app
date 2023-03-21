part of 'list_restaurant_cubit.dart';

abstract class ListRestaurantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListRestaurantInitial extends ListRestaurantState {}

class ListRestaurantLoading extends ListRestaurantState {}

class ListRestaurantLoaded extends ListRestaurantState {
  final List<Restaurant> restaurants;
  ListRestaurantLoaded({
    required this.restaurants,
  });

  @override
  List<Object?> get props => [restaurants];
}

class ListRestaurantError extends ListRestaurantState {
  final String message;
  ListRestaurantError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
