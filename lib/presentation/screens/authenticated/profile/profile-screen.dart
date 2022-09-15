import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/auth/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/auth/auth.events.dart';
import 'package:journey_share/presentation/bloc/post/post.bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.events.dart';
import 'package:journey_share/presentation/bloc/user/user.bloc.dart';
import 'package:journey_share/presentation/bloc/user/user.event.dart';
import 'package:journey_share/presentation/bloc/user/user.state.dart';

import '../../../bloc/post/post.state.dart';

class ProfileScreen extends StatelessWidget {
  final String? userId;

  const ProfileScreen({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext wContext) {
    return BlocConsumer(
      bloc: sl<UserBloc>(),
      listener: (context, state) {
        if (state is EmptyUserState) {
          BlocProvider.of<UserBloc>(wContext).add(FetchUser(userId: userId!));
        }
      },
      builder: (BuildContext context, state) {
        if (userId != null) {
          BlocProvider.of<UserBloc>(wContext).add(FetchUser(userId: userId!));
        }
        if (state is EmptyUserState) {
          return CircularProgressIndicator();
        } else if (state is UserLoaded) {
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
              ),
              _buildPostsGrid(state, context)
            ],
          );
        } else {
          return Text('Something went wrong!');
        }
      },
    );
  }

  SizedBox _buildPostsGrid(UserLoaded state, BuildContext context) {
    BlocProvider.of<PostBloc>(context).add(OnLoadingUserPosts(state.user.id));
    final posts = BlocProvider.of<PostBloc>(context).state as LoadedState;
    return SizedBox(
      height: 599,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 4,
        ),
        children: [
          for (var i in posts.fetchedPosts)
            Image.network(
              i.url,
              height: 444,
              fit: BoxFit.cover,
            )
        ],
      ),
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
