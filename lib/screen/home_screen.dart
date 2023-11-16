import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/utils/custom_formfield.dart';
import '../controller/post_controller.dart';
import '../model/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostController _postController = PostController();
  final GlobalKey<FormState> _validateKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  bool isLike = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<PostModel>>(
              stream: _postController.fetchAllPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No projects available'),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        PostModel post = snapshot.data![index];
                        return CustomFormField(
                          onTap: () {},
                          userName: post.userName ?? "",
                          postContent: post.postContent ?? "",
                          commentOnPressed: () {},
                          postId: post.id ?? "",
                          like: List<String>.from(post.like ?? []),
                        );
                      });
                }
              },
            ),
          ),
          Form(
            key: _validateKey,
            child: SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "write something "),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _postController
                              .createPost(createModel())
                              .then((value) {
                            showToast('successfully added');
                          }).catchError((error) {
                            showToast('$error');
                          });

                          _descriptionController.text = '';
                        });
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
          ),
        ],
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
      timestamp: Timestamp.now(),
      like: [],
    );
  }
}
