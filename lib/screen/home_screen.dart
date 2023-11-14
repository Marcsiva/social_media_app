import 'package:flutter/material.dart';
import '../controller/post_controller.dart';
import '../model/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostController _postController = PostController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body:StreamBuilder<List<PostModel>>(
            stream: _postController
                .fetchAllPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              else if(snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No projects available'),
                );
              }
              else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      PostModel post = snapshot.data![index];
                      return ListTile(
                          title: Container(
                              color: Colors.orange,
                              child: Text(post.postContent )),
                          //trailing: Text(post.postContent)
                      );
                    });
              }
            },
          ),
    );
  }
}
