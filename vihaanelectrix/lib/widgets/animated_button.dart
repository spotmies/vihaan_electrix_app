import 'package:flutter/material.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:like_button/like_button.dart';


animatedbutton(
    BuildContext context, id, IconData icon, MaterialColor color, String type) {
  return CircleAvatar(
    backgroundColor: Colors.grey[200],
    radius: width(context) * 0.05,
    child: LikeButton(
      // onTap: onLikeButtonTapped,
      // // onTap: type == 'wish'
      // //     ? updateWishList(context, id)
      // //     : updateCart(context, id),
      likeCountPadding: EdgeInsets.all(width(context) * 0.00),
      size: width(context) * 0.05,
      circleColor: CircleColor(start: Colors.red, end: Colors.red),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Colors.green,
        dotSecondaryColor: Colors.red,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? Icons.done : icon,
          color: isLiked ? Colors.green : color,
          size: width(context) * 0.05,
        );
      },
    ),
  );
}
