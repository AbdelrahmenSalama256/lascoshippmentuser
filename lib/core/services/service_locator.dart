import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lasco/core/cubit/global_cubit.dart';
import 'package:lasco/core/database/api/dio_consumer.dart';
import 'package:lasco/core/network/local_network.dart';
import 'package:lasco/features/auth/data/repo/login_repo.dart';
import 'package:lasco/features/auth/data/repo/sign_up_repo.dart';
import 'package:lasco/features/profile/data/repo/profile_repo.dart';

import '../../features/favourite/data/repo/favorites_repo.dart';
import '../../features/home/data/repo/company_repo.dart';

final sl = GetIt.instance;
void initServiceLocator() {
//!external
  sl.registerLazySingleton(() => CacheHelper());
  sl.registerLazySingleton(() => GlobalCubit());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DioConsumer(sl<Dio>()));
  sl.registerLazySingleton(() => SignUpRepo(sl<DioConsumer>()));
  sl.registerLazySingleton(() => LoginRepo(sl<DioConsumer>()));
  sl.registerLazySingleton(() => ProfileRepo(sl<DioConsumer>()));
  sl.registerLazySingleton(() => CompanyRepo(sl<DioConsumer>()));
  sl.registerLazySingleton(() => FavoritesRepo(sl<DioConsumer>()));
  // sl.registerLazySingleton(() => DataConnectionChecker());
  // sl.registerLazySingleton(() => NetworkInfoImpl(sl<DataConnectionChecker>()));
  //! Repositorys
}
