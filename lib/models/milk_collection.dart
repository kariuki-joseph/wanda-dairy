import 'package:cloud_firestore/cloud_firestore.dart';

class MilkCollection {
  String id;
  String farmerId;
  String farmerName;
  double volumeInLitres;
  String collectionDate;
  double pricePerLitre;
  double earnings;

  MilkCollection({
    required this.id,
    required this.farmerId,
    required this.farmerName,
    required this.volumeInLitres,
    required this.collectionDate,
    required this.pricePerLitre,
    required this.earnings,
  });

  factory MilkCollection.fromDocument(DocumentSnapshot doc) {
    return MilkCollection(
      id: doc['id'],
      farmerId: doc['farmerId'],
      farmerName: doc['farmerName'],
      volumeInLitres: doc['volumeInLitres'],
      collectionDate: doc['collectionDate'],
      pricePerLitre: doc['pricePerLitre'],
      earnings: doc['earnings'],
    );
  }

  static List<MilkCollection> fromDocumentList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => MilkCollection.fromDocument(doc))
        .toList();
  }
}
