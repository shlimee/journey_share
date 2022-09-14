import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/auth/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/auth/auth.events.dart';
import 'package:journey_share/presentation/bloc/user/user.bloc.dart';
import 'package:journey_share/presentation/bloc/user/user.event.dart';
import 'package:journey_share/presentation/bloc/user/user.state.dart';

class ProfileScreen extends StatelessWidget {
  final String? userId;

  const ProfileScreen({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext wContext) {
    return BlocConsumer(
      bloc: sl<UserBloc>(),
      listener: (context, state) {
        if (state is EmptyState) {
          BlocProvider.of<UserBloc>(wContext).add(FetchUser(userId: userId!));
        }
      },
      builder: (BuildContext context, state) {
        if (userId != null) {
          BlocProvider.of<UserBloc>(wContext).add(FetchUser(userId: userId!));
        }
        if (state is EmptyState) {
          return CircularProgressIndicator();
        } else {
          return Column(
            children: [
              _profileIcon(),
              _userName(state),
              OutlinedButton(
                onPressed: () async {
                  BlocProvider.of<AuthBloc>(context).add(OnLogoutAttempt());
                  await Navigator.of(context)
                      .pushNamedAndRemoveUntil('/auth', (_) => false);
                },
                child: const Text('Logout'),
              )
            ],
          );
        }
      },
    );
  }

  Text _userName(state) {
    return Text(state.user.userName.toString());
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
