import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/model/user_model.dart';

class UserController{
  late UserModel? currentUser;
  final userCollection = FirebaseFirestore.instance.collection('userData');

  Future<void> createUser (UserModel userData) async{
    await userCollection.doc().set(userData.tojson());
  }

  Future<UserModel?> fetchUser(String uid) async {
    final snapshots = await userCollection.where("uid", isEqualTo: uid).get();
    if (snapshots.docs.isNotEmpty) {
      currentUser = UserModel.fromJson(snapshots.docs.first.data());
      return currentUser;
    }
    return null;
  }
  Future<void> updateUser(UserModel userData) async{
    try{
      await userCollection.doc(userData.id).update(userData.tojson());
    }
    catch(e){
      print(e);
    }
  }

}