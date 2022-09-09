import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/auth/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/auth/auth.state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl<AuthBloc>(),
      builder: (context, state) => Column(
        children: [
          _profileIcon(),
          _userName(state),
        ],
      ),
    );
  }

  Text _userName(Object? state) {
    return Text((state as AuthenticatedState)
        .token
        .decryptedObject['userName']
        .toString());
  }

  Padding _profileIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: SizedBox(
          width: 96,
          height: 96,
          child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Colors.white30, Colors.black12]),
                borderRadius: BorderRadius.circular(91)),
            child: const Icon(
              Icons.person,
              color: Color(0x9E50df49),
              size: 64,
            ),
          ),
        ),
      ),
    );
  }
}
