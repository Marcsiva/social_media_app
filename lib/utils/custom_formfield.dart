// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  Function likeOnPressed;
  Function commentOnPressed;
  Function onTap;
  String userName;
  String postContent;
  CustomFormField(
      {super.key,
      required this.userName,
      required this.onTap,
      required this.postContent,
      required this.likeOnPressed,
      required this.commentOnPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1,
          color: Colors.grey)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: GestureDetector(
                onTap: onTap(),
                child: Text(userName,
                style: const TextStyle(
                  color: Colors.grey
                ),),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                  border: Border.all(width: 0.5,color: Colors.grey.shade100)
                ),
                //height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: SingleChildScrollView(
                    child:  Text(postContent,
                    style: const TextStyle(fontSize: 16),),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: likeOnPressed(), icon: const Icon(Icons.favorite)),
                IconButton(onPressed: commentOnPressed(), icon: const Icon(Icons.comment)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
