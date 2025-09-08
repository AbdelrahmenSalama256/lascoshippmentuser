import '../../data/models/favourite_response.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteModel> favorites;

  FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoritesState {
  final String error;

  FavoritesError(this.error);
}

class FavoritesSuccess extends FavoritesState {
  final String message;

  FavoritesSuccess(this.message);
}

class ToggleFavoritesLoading extends FavoritesState {}

class ToggleFavoritesLoaded extends FavoritesState {
  final List<FavoriteModel> favorites;

  ToggleFavoritesLoaded(this.favorites);
}

class ToggleFavoritesError extends FavoritesState {
  final String error;

  ToggleFavoritesError(this.error);
}

class ToggleFavoritesSuccess extends FavoritesState {
  final String message;

  ToggleFavoritesSuccess(this.message);
}
