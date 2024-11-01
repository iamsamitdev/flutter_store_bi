// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_store/dashboard.dart';
import 'package:flutter_store/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ตัวแปรสำหรับเก็บค่าจากฟอร์ม
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/gnslogo.png',
                  width: 100,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: 'mor_2314',
                  onSaved: (value) => _email = value!,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: '83r5^_',
                  obscureText: true,
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      try {
                        // Call API Login
                        var response = await CallAPI().loginAPI(
                          {
                            'username': _email,
                            'password': _password
                          }
                        );

                        var body = jsonDecode(response.body);

                        // print(body['token']);

                        // Create Shared Preferences
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        // Save Token to Shared Preferences
                        prefs.setString('token', body['token']);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(child: Text('Login Success')),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        // Navigate to Dashboard
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context, 
                          MaterialPageRoute(builder: (context) => const Dashboard())
                        );

                      } catch (e) {
                        print('Error: $e');
                        // Show message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(child: Text('Login Failed')),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Login'),
                ),
              ]
            ),
          )
        ),
      ),
    );
  }
}
