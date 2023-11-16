import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/Screen/home_screen.dart';
import 'package:social_media_app/controller/navigation_controller.dart';
import 'package:social_media_app/controller/user_controller.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/model/user_model.dart';
import 'package:social_media_app/screen/profile_register_screen.dart';
import 'package:social_media_app/theme/theme_provider.dart';
import 'package:social_media_app/utils/utils.dart';
import 'Screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool themeBool = prefs.getBool("isDark") ?? false;
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(isDark: themeBool),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        theme: themeProvider.getTheme,
        debugShowCheckedModeBanner: false,
        home: const UserDeciderScreen(),
      );
    });
  }
}

class UserDeciderScreen extends StatefulWidget {
  const UserDeciderScreen({super.key});

  @override
  State<UserDeciderScreen> createState() => _UserDeciderScreenState();
}

class _UserDeciderScreenState extends State<UserDeciderScreen> {
  UserController controller = UserController();
  UserModel? user;
  FetchState state = FetchState.response;
  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  fetchUser() {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      state = FetchState.loading;
      controller.fetchUser(currentUser.uid).then((value) {
        setState(() {
          state = FetchState.response;
          user = value;
        });
      }).catchError((error) {
        state = FetchState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const LoginScreen();
    } else if (state == FetchState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state == FetchState.error) {
      return const Center(
        child: Text("Please try again"),
      );
    } else if (user?.uid == null) {
      return  UserRegisterScreen();
    } else {
      return const HomeScreen();
    }
  }
}
