
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/model/post_model.dart';


class PostController {

  final postCollection = FirebaseFirestore.instance.collection('post');

  Future<void> createPost (PostModel collect) async{
    await postCollection.doc(collect.id).set(collect.toJson());
  }

  // Stream<List<PostModel>> fetchPost (String uid){
  //   return postCollection.where("uid",isEqualTo: uid).snapshots().map((snapshot) {
  //     return snapshot.docs.map((document) {
  //       return PostModel.fromDoc(document);
  //     }).toList();
  //   });
  // }
  // Stream<List<PostModel>> fetchAllPosts() {
  //   return postCollection.snapshots().map((snapshot) {
  //     return snapshot.docs.map((document) {
  //       return PostModel.fromDoc(document);
  //     }).toList();
  //   });
  // }
  Stream<List<PostModel>> fetchAllPosts() {
    return postCollection
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        return PostModel.fromDoc(document);
      }).toList();
    });
  }

  Future<void> updatePost(PostModel model) async{
    try{
      await postCollection.doc(model.id).update(model.toJson());
    }
    catch(e){
      print('$e');
    }
  }

  Future<void> deletePost(PostModel model) async{
    try{
      await postCollection.doc(model.id).delete();
    }
    catch(e){
      print('$e');
    }
  }
}