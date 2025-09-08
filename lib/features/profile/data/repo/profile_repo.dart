import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lasco/core/constants/widgets/print_util.dart';

import '../../../../core/constants/widgets/errors/exceptions.dart';
import '../../../../core/database/api/api_consumer.dart';
import '../../../../core/database/api/end_points.dart';
import '../../../auth/data/models/sign_up_models.dart';

class ProfileRepo {
  final ApiConsumer api;

  ProfileRepo(this.api);

  //! Logout
  Future<Either<String, ResponseModel>> userLogout() async {
    try {
      final Response response = await api.delete(EndPoints.userLogout);
      return Right(ResponseModel.fromJson(response.data));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } catch (e) {
      return Left(e.toString());
    }
  }

  //! Delete Account
  Future<Either<String, ResponseModel>> deleteAccount() async {
    try {
      final Response response = await api.get(EndPoints.deleteAccount);
      return Right(ResponseModel.fromJson(response.data));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ResponseModel>> getUserProfile() async {
    try {
      final response = await api.get(EndPoints.getProfile);
      return Right(ResponseModel.fromJson(response.data));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ResponseModel>> updateProfile({
    required String username,
    required String phone,
    required String email,
    XFile? image,
    String? password,
    String? countryCode,
  }) async {
    try {
      PrintUtil.debug('Creating FormData...');

      final formData = FormData.fromMap({
        'username': username,
        'phone': phone,
        'email': email,
        'country_code': countryCode ?? '+20',
        '_method': 'PUT',
      });

      if (password != null && password.isNotEmpty && password.length >= 8) {
        formData.fields.add(MapEntry('password', password));
      }

      if (image != null) {
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(
            image.path,
            filename: image.name.isNotEmpty ? image.name : 'profile_image.jpg',
          ),
        ));
      }

      PrintUtil.debug('FormData fields: ${formData.fields}');
      PrintUtil.debug('FormData files: ${formData.files}');

      final response = await api.post(
        EndPoints.updateProfile,
        data: formData, // FormData directly
        isFormData: true,
      );

      PrintUtil.debug('Response status: ${response.statusCode}');
      PrintUtil.debug('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic data = response.data;
        if (data is String) {
          return Right(ResponseModel.fromJson({'message': data}));
        } else {
          return Right(ResponseModel.fromJson(data));
        }
      } else {
        String errorMsg = response.statusMessage ??
            'Update failed (status: ${response.statusCode})';
        if (response.data != null && response.data is Map<String, dynamic>) {
          final apiErrors = response.data['errors'] as Map<String, dynamic>?;
          if (apiErrors != null) {
            if (apiErrors['password'] != null) {
              errorMsg = 'Password error: ${apiErrors['password'].join(', ')}';
            } else if (apiErrors['email'] != null) {
              errorMsg = 'Email error: ${apiErrors['email'].join(', ')}';
            } else {
              errorMsg +=
                  ' - ${response.data['message'] ?? 'Validation failed'}';
            }
          }
        }
        return Left(errorMsg);
      }
    } on DioException catch (e) {
      PrintUtil.error('Dio error: ${e.message}');
      if (e.response != null) {
        PrintUtil.error('Response: ${e.response?.data}');
        return Left('Server error: ${e.response?.data ?? e.message}');
      }
      return Left('Network error: ${e.message}');
    } catch (e) {
      PrintUtil.error('Unexpected error: $e');
      return Left('Failed to update profile: $e');
    }
  }

  //! Register
  Future<Either<String, ResponseModel>> sendEmailVerificationOtp({
    required String email,
  }) async {
    try {
      final response = await api.post(
        EndPoints.sendEmailVerificationOtp,
        data: {
          "email": email,
        },
      );

      return Right(ResponseModel.fromJson(response.data));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ResponseModel>> verifyEmailOtp({
    required String email,
    required String code,
  }) async {
    try {
      final response = await api.post(
        EndPoints.verifyEmailOtp,
        data: {
          "email": email,
          "code": code,
        },
      );

      return Right(ResponseModel.fromJson(response.data));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
