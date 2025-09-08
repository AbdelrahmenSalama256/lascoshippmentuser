import 'package:bloc/bloc.dart';
import 'package:lasco/features/favourite/views/cubit/favorites_state.dart';

import '../../../../core/common/logs.dart';
import '../../data/models/favourite_response.dart';
import '../../data/repo/favorites_repo.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo favoritesRepo;

  FavoritesCubit(this.favoritesRepo) : super(FavoritesInitial());

  List<FavoriteModel> favorites = [];

  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    final result = await favoritesRepo.getFavorites();
    result.fold(
      (error) {
        Print.error(error);
        emit(FavoritesError(error));
      },
      (companyResponse) {
        favorites = companyResponse.data?.favorites ?? [];
        emit(FavoritesLoaded(favorites));
      },
    );
  }

  Future<void> toggleFavorite(int companyId) async {
    emit(ToggleFavoritesLoading());
    final result = await favoritesRepo.toggleFavorite(companyId);
    result.fold(
      (error) {
        Print.error(error);
        emit(ToggleFavoritesError(error));
        getFavorites();
      },
      (message) {
        emit(ToggleFavoritesSuccess(message));
        getFavorites();
      },
    );
  }
}
