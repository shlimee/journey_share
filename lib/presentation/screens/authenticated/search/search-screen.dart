import 'package:flutter/material.dart';
import 'package:journey_share/style/text.styles.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'Search',
                style: TextStyles.titleFaded,
              )),
          Center(
            child: TextFormField(style: TextStyles.title),
          ),
        ],
      ),
    );
  }
}
