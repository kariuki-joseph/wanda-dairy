import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  bool isAdmin = false;
  String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.isAdmin,
    required this.password,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      phone: doc['phone'],
      isAdmin: doc['isAdmin'],
      password: doc['password'],
    );
  }

  static List<UserModel> fromDocumentList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();
  }
}
