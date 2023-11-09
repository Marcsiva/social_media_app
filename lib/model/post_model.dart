import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostModel{
  String? id;
  String uid;
  String postContent;
  String userName;

  PostModel({
    this.id,
    required this.uid,
   required this.userName,
    required this.postContent
  });
  Map<String,dynamic>toJson(){
    return{
      'uid':uid,
      'id':id,
      'PostContent': postContent,
      'userName' : userName
    };
  }
  factory PostModel.fromJson(
      QueryDocumentSnapshot<Map<String,dynamic>>doc){
    return PostModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        id: doc.id,
        postContent: doc.get('postContent'),
      userName: doc.get('userName')
    );
  }
}