import 'package:flutter/material.dart';
import 'package:journey_share/data/models/user_model.dart';
import 'package:journey_share/style/text.styles.dart';

import '../../domain/entities/user.dart';

class FeedPost extends StatelessWidget {
  final User user;
  final String description;
  final String url;
  const FeedPost({
    Key? key,
    required this.user,
    required this.description,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 468,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Row(
              children: [
                Icon(Icons.person),
                Text(
                  user.userName,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Image.network(url),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Row(
              children: [
                Icon(
                  Icons.star_outline,
                  size: 48,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                user.userName,
                style: TextStyles.h4,
              ),
              const SizedBox(width: 15),
              Text(
                description,
                textAlign: TextAlign.start,
              )
            ],
          )
        ],
      ),
    );
  }
}
