import 'package:flutter/material.dart';
import 'package:lab_7/users_model.dart';
import 'package:sqflite/sqflite.dart';

class SecondScreen extends StatelessWidget {
  final List<UserModel> savedUsers;
  final Database database;

  const SecondScreen(
      {Key? key, required this.savedUsers, required this.database})
      : super(key: key);

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateBack(context);
        },
        tooltip: 'Go Back',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
