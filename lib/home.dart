import 'package:flutter/material.dart';
import 'package:flutter_store/login.dart';
import 'package:flutter_store/regsiter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to BI Team'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const Login())
                    );
                  },
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  child: const Text('Register'),
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const Register())
                    );
                  },
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}