import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final Map<String,String> links;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.links
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      password: doc['pass'],
      phoneNumber: doc['displayName'],
      links: doc['Links'],
    );
  }
}
