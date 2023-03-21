part of 'detail_restaurant_cubit.dart';

abstract class DetailRestaurantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailRestaurantInitial extends DetailRestaurantState {}

class DetailRestaurantLoading extends DetailRestaurantState {}

class DetailRestaurantLoaded extends DetailRestaurantState {
  final RestaurantDetail detail;
  DetailRestaurantLoaded({
    required this.detail,
  });

  @override
  List<Object?> get props => [detail];
}

class DetailRestaurantError extends DetailRestaurantState {
  final String message;
  DetailRestaurantError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
