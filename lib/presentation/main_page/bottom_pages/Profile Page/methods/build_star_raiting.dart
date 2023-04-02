import 'package:flutter/material.dart';

Row buildStarRating(double rating, {double size = 21, bool isCenter = true}) {
  var starList = <Widget>[];
  for (var i = 1; i <= 5; i++) {
    if (i <= rating && i - rating <= 1) {
      starList.add(Icon(
        Icons.star,
        color: const Color(0xffFFCB18),
        size: size,
      ));
    } else if (i - rating > 1 && i - rating < 0) {
      starList.add(Icon(
        Icons.star_half,
        color: const Color(0xffFFCB18),
        size: size,
      ));
    } else {
      starList.add(Icon(
        Icons.star_border,
        color: const Color(0xffFFCB18),
        size: size,
      ));
    }
  }
  return Row(
    mainAxisAlignment:
        isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
    children: starList,
  );
}
