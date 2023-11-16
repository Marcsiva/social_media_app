
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/model/post_model.dart';


class PostController {

  final postCollection = FirebaseFirestore.instance.collection('post');
 // final likeCollection = FirebaseFirestore.instance.collection('like');

  Future<void> createPost (PostModel collect) async{
    await postCollection.doc(collect.id).set(collect.toJson());
  }

  Stream<List<PostModel>> fetchAllPosts() {
    return postCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        return PostModel.fromDoc(document);
      }).toList();
    });
  }

  Future<void>  addLikePost(String postId, String userId) async{
    try{
      DocumentReference docRef= postCollection.doc(postId);
      await docRef.update({'like': FieldValue.arrayUnion([userId])});
    }catch (e){
      print('$e');
    }
  }
  Future<void> deleteLikePost(String postId,String userId) async{
    try{
      DocumentReference docRef= postCollection.doc(postId);
      await docRef.update({'like': FieldValue.arrayRemove([userId])});
    }catch (e){
      print('$e');
    }
  }




  Future<void> updatePost(PostModel model) async{
    try{
     DocumentReference docRef = postCollection.doc(model.id);

     await docRef.update(model.toJson());
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
  Future<bool> isUserLiked(String postId, String userId) async {
    try {
      DocumentSnapshot postSnapshot = await postCollection.doc(postId).get();

      if (postSnapshot.exists) {
        Map<String, dynamic> postData = postSnapshot.data() as Map<String, dynamic>;
        List<String> likes = List<String>.from(postData['like']);

        return likes.contains(userId);
      }

      return false;
    } catch (e) {
      print('Error checking if user is liked: $e');
      return false;
    }
  }

  Future<int> getLikeCount(String postId) async {
    try {
      DocumentSnapshot postSnapshot = await postCollection.doc(postId).get();

      if (postSnapshot.exists) {
        Map<String, dynamic> postData = postSnapshot.data() as Map<String, dynamic>;
        List<String> likes = List<String>.from(postData['like']);

        return likes.length;
      }

      return 0;
    } catch (e) {
      print('Error getting like count: $e');
      return 0;
    }
  }
  Stream<List<String>> getAllComments(String postId) {
    try {
      return postCollection.doc(postId).snapshots().map((postSnapshot) {
        if (postSnapshot.exists) {
          Map<String, dynamic> postData = postSnapshot.data() as Map<String, dynamic>;

          return (postData['comments'] as List<dynamic>?)
              ?.map((comment) => comment.toString())
              .toList() ??
              [];
        }
        return [];
      });
    } catch (e) {
      print('Error getting comments: $e');
      // You might want to return an error state instead of an empty list here
      return Stream.value([]);
    }
  }


  Future<void> addComment(String postId, String comment) async {
    try {
      DocumentReference docRef = postCollection.doc(postId);

      await docRef.update({
        'comments': FieldValue.arrayUnion([

            // 'userId': userId,
             comment,

        ])
      });
    } catch (e) {
      print('$e');
    }
  }
}
