import 'package:flutter/material.dart';
import 'package:journey_share/data/models/user_model.dart';
import 'package:journey_share/style/text.styles.dart';

import '../../../../../domain/entities/user.dart';

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
      child: Column(
        children: [
          _userDetails(),
          _image(),
          _actionButtons(),
          _postDescription(),
        ],
      ),
    );
  }

  Padding _userDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Row(
        children: [
          Icon(Icons.person),
          Text(
            user.userName,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  GestureDetector _image() {
    return GestureDetector(
      child: Stack(children: [
        Container(height: 496, child: Image.network(url, fit: BoxFit.cover)),
        Center(
            child: Icon(
          Icons.favorite,
          size: 96,
          color: Colors.white70,
        ))
      ], alignment: Alignment.center),
      onDoubleTap: _doubleTappedImage,
    );
  }

  Padding _actionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Row(
        children: const [
          Icon(
            Icons.favorite_border,
            size: 32,
          ),
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.chat_bubble_outline,
            size: 32,
          ),
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.send_rounded,
            size: 32,
          )
        ],
      ),
    );
  }

  Container _postDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            user.userName,
            style: TextStyles.h6,
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Text(
              description,
              textAlign: TextAlign.start,
              overflow: TextOverflow.fade,
            ),
          )
        ],
      ),
    );
  }

  void _doubleTappedImage() {
    print("syes");
  }
}
