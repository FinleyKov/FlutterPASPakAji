import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Login Page")),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const TextField(
              decoration: InputDecoration(hintText: "Masukkan username"),
            ),
          ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(hintText: "Masukkan password"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Login", style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Register"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
