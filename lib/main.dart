import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/post.bloc.dart';
import 'package:journey_share/presentation/bloc/state/auth.state.dart';
import 'package:journey_share/presentation/bloc/state/states.dart';
import 'package:journey_share/presentation/pages/login-screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
      ],
      child: MaterialApp(
        title: 'JourneyShare',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const LoginScreen(),
        //home: const RootPage(title: 'JourneyShare'),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Upload'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(size: 32),
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
