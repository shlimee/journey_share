import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:journey_share/data/datasources/auth_remote_data_source.dart';
import 'package:journey_share/data/datasources/post_remote_data_source.dart';
import 'package:journey_share/data/repositories/auth_repository_impl.dart';
import 'package:journey_share/data/repositories/post_repository_impl.dart';
import 'package:journey_share/domain/repositories/auth_repository.dart';
import 'package:journey_share/domain/repositories/post_repository.dart';
import 'package:journey_share/domain/usecases/get_posts.dart';
import 'package:journey_share/domain/usecases/login.dart';
import 'package:journey_share/enviroment.dart';
import 'package:journey_share/presentation/bloc/auth/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.bloc.dart';
import 'package:journey_share/presentation/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
final apiUrl = Environment().config!.apiUrl;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerLazySingleton(
    () => AuthBloc(
      login: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => PostBloc(
      getPosts: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => GetPosts(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiUrl: apiUrl),
  );
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(apiUrl: apiUrl),
  );

  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => NavigationService());
}
