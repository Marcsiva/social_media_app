import 'package:cloud_firestore/cloud_firestore.dart';


class PostModel {
  String? id;
  String uid;
  String? postContent;
  String? userName;
  Timestamp timestamp;
  List<String> like;

  PostModel(
      {this.id,
      required this.uid,
       this.userName,
       this.postContent,
      required this.timestamp,
      required this.like,
     });


  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'id': id,
      'postContent': postContent,
      'userName': userName,
      'timestamp':timestamp,
      'like':like,
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
      like: (data['like'] as List<dynamic>?)?.map((like) => like.toString()).toList() ?? [],
      // Include other fields as needed
    );
  }
}
// class LikeModel{
//   String ? id;
//   String ?likeUserName;
//
//   LikeModel(
//   {
//     this.id,
//      this.likeUserName
// });
//   Map<String,dynamic> toJson(){
//     return{
//       'id':id,
//       'likeUserName' : likeUserName
//     };
//   }
//   factory LikeModel.fromDoc(QueryDocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//
//     return LikeModel(
//       id: doc.id,
//      likeUserName: data['likeUserName'] ??''
//     );
//   }
// }
//
// class CommentModel{
//   String ? id;
//   String ?commentUserName;
//   String ?comments;
//
//   CommentModel(
//       {
//         this.id,
//         required this.commentUserName,
//         required this.comments
//       });
//   Map<String,dynamic> toJson(){
//     return{
//       'id':id,
//       'commentUserName' : commentUserName
//     };
//   }
//   factory CommentModel.fromDoc(QueryDocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//
//     return CommentModel(
//         id: doc.id,
//         commentUserName: data['commentUserName'] ??'',
//         comments: data['comments'] ?? ''
//     );
//   }
// }