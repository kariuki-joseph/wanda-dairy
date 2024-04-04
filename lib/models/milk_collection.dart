import 'package:cloud_firestore/cloud_firestore.dart';

class MilkCollection {
  String id;
  String farmerId;
  String farmerName;
  String phone;
  double volumeInLitres;
  DateTime collectionDate;
  double pricePerLitre;
  bool isPaid;

  MilkCollection({
    required this.id,
    required this.farmerId,
    required this.farmerName,
    required this.phone,
    required this.volumeInLitres,
    required this.collectionDate,
    required this.pricePerLitre,
    this.isPaid = false,
  });

  factory MilkCollection.fromDocument(DocumentSnapshot doc) {
    return MilkCollection(
      id: doc['id'],
      farmerId: doc['farmerId'],
      farmerName: doc['farmerName'],
      phone: doc['phone'],
      volumeInLitres: doc['volumeInLitres'],
      collectionDate: (doc['collectionDate'] as Timestamp).toDate(),
      pricePerLitre: doc['pricePerLitre'],
      isPaid: doc['isPaid'] ?? false,
    );
  }

  static List<MilkCollection> fromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => MilkCollection.fromDocument(doc))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'farmerId': farmerId,
      'farmerName': farmerName,
      'phone': phone,
      'volumeInLitres': volumeInLitres,
      'collectionDate': Timestamp.fromDate(collectionDate),
      'pricePerLitre': pricePerLitre,
      'isPaid': isPaid,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is MilkCollection) {
      return farmerId == other.farmerId;
    }
    return false;
  }

  @override
  int get hashCode => farmerId.hashCode;
}
