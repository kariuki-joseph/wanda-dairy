import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  String id;
  String name;
  String email;
  String phone;
  String password;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory Admin.fromDocument(DocumentSnapshot doc) {
    return Admin(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      phone: doc['phone'],
      password: doc['password'],
    );
  }
}
