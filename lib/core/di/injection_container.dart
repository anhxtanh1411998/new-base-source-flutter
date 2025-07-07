import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth/get_current_user.dart';
import '../../domain/usecases/auth/is_logged_in.dart';
import '../../domain/usecases/auth/login.dart';
import '../../domain/usecases/auth/logout.dart';
import '../../domain/usecases/auth/register.dart';
import '../../presentation/blocs/language/language.dart';
import '../../presentation/blocs/theme/theme.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';

final GetIt sl = GetIt.instance();

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);

  // Blocs
  sl.registerFactory(() => LanguageBloc());
  sl.registerFactory(() => ThemeBloc());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(repository: sl()));
  sl.registerLazySingleton(() => Register(repository: sl()));
  sl.registerLazySingleton(() => Logout(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUser(repository: sl()));
  sl.registerLazySingleton(() => IsLoggedIn(repository: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => ApiClient(dio: sl()));
}
