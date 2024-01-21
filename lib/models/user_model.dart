import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  bool isAdmin;
  String password;

  UserModel({
    this.id = "",
    this.name = "",
    this.email = "",
    this.phone = "",
    this.isAdmin = false,
    this.password = "",
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isAdmin': isAdmin,
      'password': password,
    };
  }
}
