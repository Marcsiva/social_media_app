import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/controller/user_controller.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/model/user_model.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final GlobalKey<FormState> _validateKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final UserController _userRegisterController = UserController();

  @override
  void initState() {
    _userNameController.text = FirebaseAuth.instance.currentUser?.displayName ?? "";
    _emailController.text = FirebaseAuth.instance.currentUser?.email??"";
    _phoneNumberController.text = FirebaseAuth.instance.currentUser?.phoneNumber ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body:

      SingleChildScrollView(
        child: Form(
          key: _validateKey,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser?.photoURL ?? ""
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //const Text("User Name",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _userNameController,
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          labelText: "User Name",
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.mail),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _emailController,
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.help),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _descriptionController,
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          labelText: "Description",
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(onPressed: (){
                _userRegisterController.createUser(createModel()).then((value) {
                  showToast("Welcome");
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const UserDeciderScreen()));
                });
              }, child: const Text("Next"))
            ],
          ),
        ),
      ),
    );
  }

  UserModel createModel() {
    return UserModel(
        uid: FirebaseAuth.instance.currentUser?.uid ?? "",
        username: _userNameController.text,
        email: _emailController.text,
    phonenumber: _phoneNumberController.text,
    image: FirebaseAuth.instance.currentUser?.photoURL??"",
      description: _descriptionController.text
    );
  }
  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.grey.shade800);
  }
}
