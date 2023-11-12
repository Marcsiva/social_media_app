import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/controller/navigation_controller.dart';
import 'package:social_media_app/controller/post_controller.dart';
import 'package:social_media_app/model/post_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostController _postController = PostController();
  final GlobalKey<FormState> _validateKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('create post'),
      ),
      body: Form(
        key: _validateKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _postController.createPost(createModel()).then((value) {
              showToast('successfully added');
            }).catchError((error) {
              showToast('$error');
            });
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NavigationScreen()));
            _descriptionController.text = '';
          });
        },
        child: const Text('post'),
      ),
    );
  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.grey);
  }

  PostModel createModel() {
    return PostModel(
      postContent: _descriptionController.text.trim(),
      uid: FirebaseAuth.instance.currentUser!.uid,
      userName: FirebaseAuth.instance.currentUser?.displayName ?? "",
    );
  }
}
