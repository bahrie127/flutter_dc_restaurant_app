part of 'favorite_detail_cubit.dart';

abstract class FavoriteDetailState extends Equatable {
  const FavoriteDetailState();

  @override
  List<Object> get props => [];
}

class FavoriteDetailInitial extends FavoriteDetailState {}

class FavoriteDetailLoading extends FavoriteDetailState {}

class FavoriteDetailNotFound extends FavoriteDetailState {}
class FavoriteDetailFound extends FavoriteDetailState {}

class FavoriteDetailSuccess extends FavoriteDetailState {
  final String message;
  const FavoriteDetailSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class FavoriteDetailError extends FavoriteDetailState {
  final String message;
  const FavoriteDetailError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}