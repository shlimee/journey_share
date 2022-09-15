import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.events.dart';
import 'package:journey_share/presentation/bloc/post/post.state.dart';
import 'package:journey_share/presentation/widgets/refresh_indicator.dart';

import 'widgets/feed-post.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext fsContext) {
    BlocProvider.of<PostBloc>(fsContext).add(OnLoadingAllPosts());

    return CheckmarkRefreshIndicator(
      onLoadedCallback: () {
        BlocProvider.of<PostBloc>(fsContext).add(OnLoadingAllPosts());
      },
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: BlocConsumer<PostBloc, PostState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedState) {
                  return Column(
                    children: [
                      for (var i in (state).fetchedPosts)
                        FeedPost(
                            description: i.description,
                            user: i.user,
                            url: i.url)
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      _showRefreshDoneSnackBar(BuildContext fsContext) {
    return ScaffoldMessenger.of(fsContext).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Cool',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: const Text('New posts are to be seen!'),
        duration: const Duration(milliseconds: 2000),
        width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
