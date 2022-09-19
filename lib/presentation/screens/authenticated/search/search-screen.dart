import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/search/search.bloc.dart';
import 'package:journey_share/presentation/bloc/search/search.events.dart';
import 'package:journey_share/style/text.styles.dart';

import '../../../bloc/search/search.states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: sl<SearchBloc>(),
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Search for a place to visit or a friend',
                      style: TextStyles.titleFaded,
                    )),
                Center(
                  child: TextFormField(
                    style: TextStyles.title,
                    onChanged: (value) => onSearchFieldChanged(value, context),
                  ),
                ),
                Text('Posts'),
                if (state is SearchedState)
                  Expanded(
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 1,
                      ),
                      children: [
                        for (var i in state.posts)
                          Image.network(
                            i.url,
                            height: 444,
                            fit: BoxFit.cover,
                          )
                      ],
                    ),
                  ),
                Divider(height: 64),
                Text('Users'),
                if (state is SearchedState)
                  Column(
                    children: [
                      for (var i in (BlocProvider.of<SearchBloc>(context).state
                              as SearchedState)
                          .users)
                        Text(i.userName)
                    ],
                  ),
              ],
            ),
          );
        });
  }

  onSearchFieldChanged(String value, BuildContext context) {
    if (value.length < 3) return;

    BlocProvider.of<SearchBloc>(context)
        .add(OnSearchFieldChanged(searchText: value));
  }
}
