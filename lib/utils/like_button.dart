
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLike;
  Function()? onTap;
   LikeButton({super.key, required this.isLike,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        isLike? Icons.favorite: Icons.favorite_border,
        color: isLike? Colors.red: Colors.grey,
      ),
    );
  }
}
