import 'package:cloud_firestore/cloud_firestore.dart';


class PostModel {
  String? id;
  String uid;
  String postContent;
  String userName;
  Timestamp timestamp;

  PostModel(
      {this.id,
      required this.uid,
      required this.userName,
      required this.postContent,
      required this.timestamp});
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'id': id,
      'postContent': postContent,
      'userName': userName,
      'timestamp':timestamp
    };
  }

  factory PostModel.fromDoc(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PostModel(
      id: doc.id,
      uid: data['uid'] ?? '',
      userName: data['userName'] ?? '',
      postContent: data['postContent'] ?? '',
      timestamp: data['timestamp'] ?? '',
      // Include other fields as needed
    );
  }
}
