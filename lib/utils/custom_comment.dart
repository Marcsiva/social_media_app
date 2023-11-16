// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
class CustomComment extends StatefulWidget {
  String userName;
  String comment;
   CustomComment({super.key,required this.userName,required this.comment});

  @override
  State<CustomComment> createState() => _CustomCommentState();
}

class _CustomCommentState extends State<CustomComment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1
        ),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('@${widget.userName}')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8,left: 8,right: 8,top: 0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade500
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.comment),
              ),
            ),
          )
        ],
      ),
    );
  }
}
