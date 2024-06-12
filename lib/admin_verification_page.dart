import 'package:flutter/material.dart';
import 'package:kidsy_tv/links_crud_page.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _verifyCredentials() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Replace these with your actual admin username and password
    const adminUsername = 'admin';
    const adminPassword = 'password';

    if (username == adminUsername && password == adminPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CRUD()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Credentials'),
            content: const Text('The username or password you entered is incorrect.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'A D M I N',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: const InputDecorationTheme(
                  labelStyle: TextStyle(fontSize: 12,color: Colors.black),
                  focusedBorder: InputBorder.none,
                ),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    focusNode: _usernameFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'U S E R N A M E',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    decoration: const InputDecoration(

                      labelText: 'P A S S W O R D',
                    ),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _verifyCredentials,
              child: const Text(
                'L O G I N',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(100, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


