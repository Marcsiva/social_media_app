import 'package:flutter/material.dart';
import 'package:social_media_app/Screen/home_screen.dart';
import 'package:social_media_app/screen/profile_screen.dart';


class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
   int _currentIndex = 0;
   final List<Widget> _page=[
     const HomeScreen(),
     // const PostScreen(),
     const ProfileScreen()
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'Home'),
          // BottomNavigationBarItem(icon: Icon(Icons.add),
          // label: 'add'),
          BottomNavigationBarItem(icon: Icon(Icons.person,),
          label:'profile'),
        ],

      ),
    );
  }
}
