import 'package:cloud_firestore/cloud_firestore.dart';


class PostModel {
  String? id;
  String uid;
  String postContent;
  String userName;

  PostModel(
      {this.id,
      required this.uid,
      required this.userName,
      required this.postContent});
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'id': id,
      'postContent': postContent,
      'userName': userName
    };
  }
  //
  // factory PostModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
  //   return PostModel(
  //       uid: FirebaseAuth.instance.currentUser!.uid,
  //       id: doc.id,
  //       postContent: doc.get('postContent'),
  //       userName: doc.get('userName'));
  // }
  factory PostModel.fromDoc(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PostModel(
      id: doc.id,
      uid: data['uid'] ?? '',
      userName: data['userName'] ?? '',
      postContent: data['postContent'] ?? '',
      // Include other fields as needed
    );
  }
}
