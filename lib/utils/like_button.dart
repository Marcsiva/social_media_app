
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../controller/post_controller.dart';
class LikeButtonView extends StatefulWidget {
  final String postId;
  // final String userId;
  final String currentUserId;

  const LikeButtonView({
    Key? key,
    required this.postId,
    // required this.userId,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _LikeButtonViewState createState() => _LikeButtonViewState();
}

class _LikeButtonViewState extends State<LikeButtonView> {
  bool isCurrentUserLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    // Initialize like status and count asynchronously
    _initLikeStatus();
  }

  Future<void> _initLikeStatus() async {
    bool userLiked = await PostController().isUserLiked(widget.postId, widget.currentUserId);
    int count = await PostController().getLikeCount(widget.postId);

    if (mounted) {
      setState(() {
        isCurrentUserLiked = userLiked;
        likeCount = count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isCurrentUserLiked
          ? const Icon(Icons.favorite,color: Colors.red,)
          : const Icon(Icons.favorite_border),
      onPressed: () async {
        setState(() {
          isCurrentUserLiked = !isCurrentUserLiked;
          likeCount += isCurrentUserLiked ? 1 : -1;
        });

        try {
          if (isCurrentUserLiked) {
            await PostController().addLikePost(widget.postId, widget.currentUserId);
          } else {
            await PostController().deleteLikePost(widget.postId, widget.currentUserId);
          }
        } catch (e) {
          // Handle errors
          print('Error: $e');
        }
      },
    );
  }
}
