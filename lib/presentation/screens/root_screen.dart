import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/presentation/bloc/bottom_nav/bottom_nav_cubit.dart';
import 'package:journey_share/presentation/screens/authenticated/feed/feed-screen.dart';
import 'package:journey_share/presentation/widgets/buttom_navbar.dart';

import 'authenticated/profile/profile-screen.dart';

class RootScreen extends StatelessWidget {
  RootScreen({Key? key}) : super(key: key);

  final List<Widget> _screens = [
    FeedScreen(),
    FeedScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavCubit>(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavCubit, int>(
          builder: (context, state) {
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _screens.elementAt(state));
          },
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
