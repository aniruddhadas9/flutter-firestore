import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/widgets/button.dart';
import 'auth/auth_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  final authService = AuthService();

  int _selectedIndex = 0;
  int currentPageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    if (authService.isUserLoggedIn == false) {
      log('home_screen|widget|isuserlogn|false|redirectingto loginpage');
      log('current user details${authService.getCurrentUserDetails()}');

    } else {
      log('home_screen|widget|user already login :: need to stay here');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('KRenter'),
        titleSpacing: 10,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "KRenter",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: "Sign Out",
              onPressed: () async {
                await authService.signout();
                goToLogin(context);
              },
            )
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Payment'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                // Navigator.pop(context);
                Navigator.pushNamed(context, '/paymentDetail');
              },
            ),
            ListTile(
              title: const Text('Flats'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                // Navigator.pop(context);
                Navigator.pushNamed(context, '/flatDetail');
              },
            ),
          ],
        ),
      ),
      /*bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          print(index);
          setState(() {
            currentPageIndex = index;
          });
          if(index == 0) {
            Navigator.pushNamed(context, '/main');
          }
          else if(index == 1) {
            Navigator.pushNamed(context, '/flatDetail');
          }
          else if(index == 2) {
            Navigator.pushNamed(context, '/paymentDetail');
          }
          else {
            Navigator.pushNamed(context, '/main');
          }
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Messages',
          ),
        ],
      ),
*/
      // Floating button
      floatingActionButton: FloatingActionButton(
        onPressed: goToLogin(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  goToLogin(BuildContext context){
    log('go to login page clicked');
    // Navigator.pushNamed(context, 'login');
  }
}