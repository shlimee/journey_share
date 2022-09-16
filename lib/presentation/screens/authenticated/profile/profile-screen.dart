import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/domain/entities/user.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/auth/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/auth/auth.events.dart';
import 'package:journey_share/presentation/bloc/auth/auth.state.dart';
import 'package:journey_share/presentation/bloc/post/post.bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.events.dart';
import 'package:journey_share/presentation/bloc/post/post.state.dart';
import 'package:journey_share/presentation/bloc/user/user.bloc.dart';
import 'package:journey_share/presentation/bloc/user/user.event.dart';
import 'package:journey_share/presentation/bloc/user/user.state.dart';

class ProfileScreen extends StatelessWidget {
  final String? userId;

  const ProfileScreen({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext wContext) {
    final meUser =
        (BlocProvider.of<AuthBloc>(wContext).state as AuthenticatedState).user;
    var userToShow = meUser;
    return BlocConsumer(
      bloc: sl<UserBloc>(),
      listener: (context, state) {
        if (state is UserLoaded) {
          userToShow = state.user;
        }
      },
      builder: (BuildContext context, state) {
        if (userId != null) {
          print('userid: ' + userId!);
          BlocProvider.of<UserBloc>(wContext).add(FetchUser(userId: userId!));
          if (state is UserLoaded) userToShow = state.user;
        }
        return Column(
          children: [
            _profileIcon(),
            _userName(userToShow),
            Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  if (meUser == userToShow)
                    OutlinedButton(
                      onPressed: () async {
                        BlocProvider.of<AuthBloc>(context)
                            .add(OnLogoutAttempt());
                        await Navigator.of(context)
                            .pushNamedAndRemoveUntil('/auth', (_) => false);
                      },
                      child: const Text('Logout'),
                    ),
                  if (meUser != userToShow)
                    OutlinedButton(
                      onPressed: () async {
                        BlocProvider.of<AuthBloc>(context)
                            .add(OnLogoutAttempt());
                        await Navigator.of(context)
                            .pushNamedAndRemoveUntil('/auth', (_) => false);
                      },
                      child: const Text('Follow'),
                    )
                ],
              ),
            ),
            _buildPostsGrid(userToShow, context)
          ],
        );
      },
    );
  }

  BlocConsumer _buildPostsGrid(User user, BuildContext wcontext) {
    //print((BlocProvider.of<PostBloc>(context).state as PostErrorState).errorMessage);
    BlocProvider.of<PostBloc>(wcontext).add(OnLoadingUserPosts(user.id));
    return BlocConsumer(
      bloc: sl<PostBloc>(),
      builder: (context, state) {
        if (state is LoadedUserPostsState) {
          print("possssssssts: " + state.fetchedPosts.toString());
          return Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 1,
              ),
              children: [
                for (var i in state.fetchedPosts)
                  Image.network(
                    i.url,
                    height: 444,
                    fit: BoxFit.cover,
                  )
              ],
            ),
          );
        } else {
          return Text('asd');
        }
      },
      listener: (context, state) {
        print(state);
      },
    );
  }

  Text _userName(User user) {
    return Text(user.userName.toString());
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
