import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/Screen/login_screen.dart';
import 'package:social_media_app/controller/google_auth_controller.dart';
import 'package:social_media_app/controller/user_controller.dart';
import 'package:social_media_app/model/user_model.dart';
import 'package:social_media_app/screen/profile_register_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController _authController = AuthController();
  final UserController _userController = UserController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<UserModel?>(
              future: _userController.fetchUser(
                FirebaseAuth.instance.currentUser?.uid ?? ""
              ),
              builder:(context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('User not found'));
                } else {
                  UserModel user = snapshot.data!;
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserRegisterScreen(editModel: user)));
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(FirebaseAuth
                                        .instance.currentUser?.photoURL ??
                                    ""),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user.username),
                                  Text(user.description as String)
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              }),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Align(
          //         alignment: Alignment.topLeft,
          //           child: CircleAvatar(
          //             radius: 30,
          //             backgroundImage: NetworkImage(
          //               FirebaseAuth.instance.currentUser?.photoURL ?? "",
          //             ),
          //           ),
          //         ),
          //       ),
          //     const SizedBox(width: 5),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(FirebaseAuth.instance.currentUser?.displayName ??"",
          //         style: const TextStyle(fontSize: 17,fontWeight:FontWeight.w500),),
          //         const SizedBox(
          //           height: 5,
          //         ),
          //         Text(FirebaseAuth.instance.currentUser?.email??"")
          //       ],
          //     )
          //   ],
          // ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text("signout"),
            trailing: const Icon(Icons.logout_outlined),
            onTap: () {
              setState(() {
                _authController.signOut(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              });
            },
          )
        ],
      ),
    );
  }
}
