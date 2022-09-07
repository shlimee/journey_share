import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/post.bloc.dart';
import 'package:journey_share/presentation/pages/authenticated/feed-screen.dart';
import 'package:journey_share/presentation/pages/authenticated/profile-screen.dart';

class AuthenticatedScreen extends StatefulWidget {
  const AuthenticatedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthenticatedScreen> createState() => _AuthenticatedScreenState();
}

class _AuthenticatedScreenState extends State<AuthenticatedScreen> {
  int _currentPageIndex = 1;

  final List<Widget> _screens = [
    FeedScreen(),
    FeedScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> navBarItems = [
      const BottomNavigationBarItem(label: 'Upload', icon: Icon(Icons.add)),
      const BottomNavigationBarItem(label: 'Feed', icon: Icon(Icons.home)),
      const BottomNavigationBarItem(label: 'Account', icon: Icon(Icons.person)),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('JourneyShare'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: navBarItems,
          currentIndex: _currentPageIndex,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          }),
      body: getScreenByPageIndex(_currentPageIndex),
    );
  }

  Widget getScreenByPageIndex(int currentPageIndex) {
    return _screens[currentPageIndex];
  }
}
