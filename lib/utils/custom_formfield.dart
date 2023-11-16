// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utils/like_button.dart';

class CustomFormField extends StatefulWidget {
  //void Function()? likeOnPressed;
  void Function()? commentOnPressed;
  void Function()? onTap;
  String postId;
  String userName;
  String postContent;
  List<String> like;
  CustomFormField(
      {super.key,
      required this.userName,
      required this.onTap,
      required this.postContent,
      required this.postId,
        required this.like,
      // required this.likeOnPressed,
      required this.commentOnPressed});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.like.contains(currentUser.email);
  }

  void toggleLike (){
    setState(() {
      isLiked= !isLiked;
    });
    DocumentReference postRef = FirebaseFirestore.instance.collection('post').doc(widget.postId);
    if(isLiked){
      postRef.update({
        'like':FieldValue.arrayUnion([currentUser.email])
      });
    }
    else{
      postRef.update({
        'like': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.grey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      FirebaseAuth.instance.currentUser?.photoURL ?? "",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      widget.userName,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                   ),
                //height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    // child: Text(
                    //   widget.postContent,
                    //   style: const TextStyle(fontSize: 16),
                    // ),
                    // child: ReadMoreText(
                    //   text: widget.postContent,
                    //   trimLines: 10,
                    // ),
                    child: ExpandableText(
                      widget.postContent,
                    expandText: 'Read more',
                    collapseText: 'Read less',
                    maxLines: 3,
                    linkColor: Colors.blue,
                  ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // IconButton(onPressed: likeOnPressed, icon: const Icon(Icons.favorite)),
                LikeButton(isLike: isLiked, onTap:toggleLike),
                IconButton(
                    onPressed: widget.commentOnPressed,
                    icon: const Icon(Icons.comment)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
