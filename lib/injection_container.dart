import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:journey_share/data/datasources/auth_remote_data_source.dart';
import 'package:journey_share/data/datasources/post_remote_data_source.dart';
import 'package:journey_share/data/datasources/user_remote_data_source.dart';
import 'package:journey_share/data/repositories/auth_repository_impl.dart';
import 'package:journey_share/data/repositories/post_repository_impl.dart';
import 'package:journey_share/data/repositories/user_repository_impl.dart';
import 'package:journey_share/domain/repositories/auth_repository.dart';
import 'package:journey_share/domain/repositories/post_repository.dart';
import 'package:journey_share/domain/repositories/user_repository.dart';
import 'package:journey_share/domain/usecases/get_posts.dart';
import 'package:journey_share/domain/usecases/get_user.dart';
import 'package:journey_share/domain/usecases/get_user_posts.dart';
import 'package:journey_share/domain/usecases/login.dart';
import 'package:journey_share/domain/usecases/logout.dart';
import 'package:journey_share/domain/usecases/publish.dart';
import 'package:journey_share/domain/usecases/search.dart';
import 'package:journey_share/enviroment.dart';
import 'package:journey_share/presentation/bloc/auth/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.bloc.dart';
import 'package:journey_share/presentation/bloc/search/search.bloc.dart';
import 'package:journey_share/presentation/bloc/user/user.bloc.dart';
import 'package:journey_share/presentation/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
final apiUrl = Environment().config!.apiUrl;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerLazySingleton(
    () => AuthBloc(login: sl(), logout: sl()),
  );
  sl.registerLazySingleton(
    () => PostBloc(
      getPosts: sl(),
      publish: sl(),
      getUserPosts: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UserBloc(getUser: sl()),
  );
  sl.registerLazySingleton(
    () => SearchBloc(search: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => Publish(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => GetUserPosts(sl()));
  sl.registerLazySingleton(() => Search(sl(), sl()));

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
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
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
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(apiUrl: apiUrl),
  );

  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => NavigationService());
}
