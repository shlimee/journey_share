import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/enviroment.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/auth/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.bloc.dart';
import 'package:journey_share/presentation/bloc/user/user.bloc.dart';
import 'package:journey_share/presentation/route_generator.dart';
import 'package:journey_share/presentation/services/navigation_service.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  String? environment = const String.fromEnvironment('TARGET_ENVIROMENT');
  Environment().initConfig(environment);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<PostBloc>(),
        ),
        BlocProvider<AuthBloc>(
          lazy: true,
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<UserBloc>(
          create: (_) => sl<UserBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'JourneyShare',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/auth',
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: sl<NavigationService>().navigatorKey,
      ),
    );
  }
}
