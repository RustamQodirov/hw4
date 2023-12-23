import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab_7/users_model.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  get url_ => 'https://randomuser.me/api/?results=20';

  List<UserModel> users = [];
  List<UserModel> savedUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Jinoiy guruh azolari'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetch,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              navigateToSavedScreen();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.deepPurple,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.pictureURL),
                  ),
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    user.email,
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.save,color: Colors.deepPurple,),
                    onPressed: () {
                      saveUser(user);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void fetch() async {
    final uri = Uri.parse(url_);
    final response = await http.get(uri);

    String body = '';

    if (response.statusCode == 200) {
      body = response.body;
      final json_data = jsonDecode(body);

      final results = json_data['results'] as List<dynamic>;
      final converted =
          results.map((user) => UserModel.fromJson(user)).toList();

      setState(() {
        users = converted;
      });
    }
  }

  void saveUser(UserModel user) {
    setState(() {
      savedUsers.add(user);
    });
  }

  void navigateToSavedScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(savedUsers: savedUsers),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final List<UserModel> savedUsers;

  const SecondScreen({Key? key, required this.savedUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,

        title: const Text('Ashadiy Jinoyatchilar'),
      ),
      body: Container(
        color: Colors.deepPurple,
        child: ListView.builder(
          itemCount: savedUsers.length,
          itemBuilder: (context, index) {
            final user = savedUsers[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.pictureURL),
                  ),
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    user.email,
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
