import 'package:cloud_firestore/cloud_firestore.dart';

class Farmer {
  String id;
  String name;
  String email;
  String phone;
  String password;

  Farmer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory Farmer.fromDocument(DocumentSnapshot doc) {
    return Farmer(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      phone: doc['phone'],
      password: doc['password'],
    );
  }

  static List<Farmer> fromDocumentList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Farmer.fromDocument(doc)).toList();
  }
}
