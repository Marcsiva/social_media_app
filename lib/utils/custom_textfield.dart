// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String labelName;
  String userData;
   CustomTextField({super.key,required this.labelName,required this.userData});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelName,
            style: const TextStyle(color: Colors.grey,),)),
        Text(widget.labelName,
        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline
        ),)
      ],
    );
  }
}
