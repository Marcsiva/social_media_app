import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Screen/login_screen.dart';
import 'package:social_media_app/controller/google_auth_controller.dart';
import 'package:social_media_app/controller/user_controller.dart';
import 'package:social_media_app/model/user_model.dart';
import 'package:social_media_app/screen/profile_register_screen.dart';

import '../controller/theme_controller.dart';
import '../theme/theme_provider.dart';

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
        iconTheme:  Theme.of(context).iconTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        forceMaterialTransparency: true,
        title: const Text(
          'Profile',
          style: TextStyle(
               fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
      shape: Border.all(width: 0.5),
              onSelected: (value){
        if(value == "Theme"){

        }else if(value == "signout"){
          _authController.signOut(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const LoginScreen()));
        }
              },
              icon: Icon(Icons.menu,color:Theme.of(context).primaryColor,),
              itemBuilder: (context){
            return[
              PopupMenuItem(
                  child:Consumer<ThemeProvider>(
                    builder: (context,themeProvider,child){
                    return Tooltip(
                      message: "Theme",
                      child: ListTile(
                        title: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              Text(themeProvider.getTheme  == darkTheme? 'Dark Mode':'Light Mode'),
                              const SizedBox(
                                width: 50,
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 0.6)
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.sunny,color: themeProvider.getTheme ==darkTheme? Colors.grey: Colors.amber,),
                                    const SizedBox(width: 15,),
                                    Icon(Icons.nights_stay,color: themeProvider.getTheme ==darkTheme ? Colors.blue: Colors.grey,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: (){
                          themeProvider.toggleTheme();
                        },
                      ),
                    );
                  },) ),
              PopupMenuItem(
                value: 'signout',
                  child:ListTile(
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
                  ))
            ];
          })
        ],
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
