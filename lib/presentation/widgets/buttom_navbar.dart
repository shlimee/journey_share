import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/presentation/bloc/bottom_nav/bottom_nav_cubit.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  final List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(label: 'Upload', icon: Icon(Icons.add)),
    const BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
    const BottomNavigationBarItem(label: 'Feed', icon: Icon(Icons.home)),
    const BottomNavigationBarItem(label: 'Account', icon: Icon(Icons.person)),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
        builder: ((context, state) => BottomNavigationBar(
            items: navBarItems,
            currentIndex: state,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              context.read<BottomNavCubit>().updateIndex(index);
            })));
  }
}
