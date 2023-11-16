import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String uid;
  String postContent;
  String userName;
  Timestamp timestamp;
  List<String> like;
  List<String> comments;

  PostModel(
      {this.id,
      required this.uid,
      required this.userName,
      required this.postContent,
      required this.timestamp,
      required this.like,
      required this.comments});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'id': id,
      'postContent': postContent,
      'userName': userName,
      'timestamp': timestamp,
      'like': like,
      'comments': comments
    };
  }

  void addLike(String userId) {
    if (!like.contains(userId)) {
      like.add(userId);
    }
  }

  void addComment(String comment) {
    comments.add(comment);
  }

  factory PostModel.fromDoc(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PostModel(
      id: doc.id,
      uid: data['uid'] ?? '',
      userName: data['userName'] ?? '',
      postContent: data['postContent'] ?? '',
      timestamp: data['timestamp'] ?? '',
      like: (data['like'] as List<dynamic>?)
              ?.map((like) => like.toString())
              .toList() ??
          [],
      comments: (data['comments'] as List<dynamic>?)
              ?.map((comment) => comment.toString())
              .toList() ??
          [],

      // Include other fields as needed
    );
  }
}
