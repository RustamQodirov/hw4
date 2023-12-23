import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab_7/second.dart';
import 'package:lab_7/users_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late Database _database;
  final String apiUrl = 'https://randomuser.me/api/?results=20';

  List<UserModel> users = [];
  List<UserModel> savedUsers = [];

  @override
  void initState() {
    super.initState();
    initializeDatabase();
    fetch();
  }

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'users_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, pictureURL TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> fetch() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final json_data = jsonDecode(response.body);

      final results = json_data['results'] as List<dynamic>;
      final converted =
          results.map((user) => UserModel.fromJson(user)).toList();

      setState(() {
        users = converted;
      });
    }
  }

  void saveUser(UserModel user) async {
    setState(() {
      savedUsers.add(user);
    });
  }

  void saveUserToDatabase(UserModel user) async {
    await _database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void navigateToSavedScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SecondScreen(savedUsers: savedUsers, database: _database),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Jinoiy guruh azolari'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetch,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              navigateToSavedScreen(context);
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
                    icon: const Icon(Icons.save, color: Colors.deepPurple),
                    onPressed: () {
                      saveUser(user);
                      saveUserToDatabase(user);
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
}
