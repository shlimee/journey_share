import 'package:flutter/material.dart';
import 'package:journey_share/presentation/screens/route_params.dart';
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
          _userDetails(context),
          _image(),
          _actionButtons(),
          _postDescription(),
        ],
      ),
    );
  }

  Padding _userDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Row(
        children: [
          const Icon(Icons.person),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/profile', arguments: RouteParam(arg: user.id));
            },
            child: Text(
              user.userName,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _image() {
    return GestureDetector(
      onDoubleTap: _doubleTappedImage,
      child: Stack(alignment: Alignment.center, children: [
        SizedBox(height: 496, child: Image.network(url, fit: BoxFit.cover)),
        const Center(
            child: Icon(
          Icons.favorite,
          size: 96,
          color: Colors.white70,
        ))
      ]),
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
