import 'package:flutter/material.dart';
import 'package:flutter_store/home.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(),
          ),
        ],
      ),
      body: const Center(
        child: Text('Dashboard'),  
      )
    );
  }
}