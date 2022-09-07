import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/event/post.events.dart';
import 'package:journey_share/presentation/bloc/post.bloc.dart';
import 'package:journey_share/presentation/bloc/state/post.state.dart';
import 'package:journey_share/presentation/widgets/refresh_indicator.dart';

import '../../widgets/feed-post.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);

  late PostState currentState = EmptyState();

  @override
  Widget build(BuildContext context) {
    return CheckmarkRefreshIndicator(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              currentState = state;
              print(currentState);
            },
            builder: (context, state) {
              BlocProvider.of<PostBloc>(context).add(OnLoadingPosts());
              print(currentState);
              if (currentState is LoadedState) {
                return Column(
                  children: [
                    for (var i in (currentState as LoadedState).fetchedPosts)
                      FeedPost(
                          description: i.description, user: i.user, url: i.url)
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}
