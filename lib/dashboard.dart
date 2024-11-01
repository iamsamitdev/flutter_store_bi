// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_store/bottompage/home_screen.dart';
import 'package:flutter_store/bottompage/notification_screen.dart';
import 'package:flutter_store/bottompage/profile_screen.dart';
import 'package:flutter_store/bottompage/report_screen.dart';
import 'package:flutter_store/bottompage/setting_screen.dart';
import 'package:flutter_store/home.dart';
import 'package:flutter_store/info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  // สร้างฟังก์ชันสำหรับการ logout
  void logout() async {
    // ลบ token ออกจากระบบ
    await SharedPreferences.getInstance().then((value) => value.remove('token'));

    // กลับไปยังหน้า Login
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  // สร้างตัวแปรไว้เก็บ title ของแต่ละ screen
  String _title = 'Flutter Store';

  // สร้างตัวแปรไว้เก็บ index ของ bottom navigation bar
  late int _currentIndex = 0;

  // สร้าง List ของแต่ละหน้า
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NoficationScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];

  // สร้าง method สำหรับเปลี่ยนหน้า
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0: _title = 'Home'; break;
        case 1: _title = 'Report'; break;
        case 2: _title = 'Notification'; break;
        case 3: _title = 'Setting'; break;
        case 4: _title = 'Profile'; break;
        default: _title = 'Flutter Store'; break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _title = 'Flutter Store';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('Samit'), 
                  accountEmail: Text('samit@email.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: Image.asset('assets/images/gnslogo.png').image,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Infomation'),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const Info())
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('About'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Contact'),
                  onTap: () {},
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: logout,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text('Version 1.0.0'),
                  ),
                ],
              )
            ),
          ]
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => {
          onTabTapped(value),
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart_outlined), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Setting'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ]
      ),
    );
  }
}