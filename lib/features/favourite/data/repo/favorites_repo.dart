import 'package:dartz/dartz.dart';

import '../../../../core/constants/widgets/errors/exceptions.dart';
import '../../../../core/constants/widgets/print_util.dart';
import '../../../../core/database/api/api_consumer.dart';
import '../../../../core/database/api/end_points.dart';
import '../models/favourite_response.dart';

class FavoritesRepo {
  final ApiConsumer api;

  FavoritesRepo(this.api);

  Future<Either<String, CompanyResponse>> getFavorites() async {
    try {
      final response = await api.get(EndPoints.getFavorites);
      if (response.data['success']) {
        final companyResponse = CompanyResponse.fromJson(response.data);
        return Right(companyResponse);
      } else {
        return Left(
            'Failed to fetch favorites: ${response.data['message'] ?? 'Unknown error'}');
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } catch (e) {
      PrintUtil.error('Failed to fetch favorites: $e');
      return Left('Failed to fetch favorites: $e');
    }
  }

  Future<Either<String, String>> toggleFavorite(int companyId) async {
    try {
      final response = await api.post(
        "${EndPoints.toggleFavorite}/$companyId",
      );
      if (response.data['success']) {
        return Right(
            response.data['message'] ?? 'Favorite toggled successfully');
      } else {
      return Left(
            'Failed to toggle favorite: ${response.data['message'] ?? 'Unknown error'}');
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } catch (e) {
      PrintUtil.error('Failed to toggle favorite: $e');
      return Left('Failed to toggle favorite: $e');
    }
  }
}
