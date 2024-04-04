// store a list of payments made to farmers
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String farmerId;
  String farmerName;
  double amount;
  DateTime paymentDate;

  PaymentModel({
    required this.farmerId,
    required this.farmerName,
    required this.amount,
    required this.paymentDate,
  });

  factory PaymentModel.fromDocument(DocumentSnapshot doc) {
    return PaymentModel(
      farmerId: doc['farmerId'],
      farmerName: doc['farmerName'],
      amount: doc['amount'],
      paymentDate: doc['paymentDate'].toDate(),
    );
  }

  static List<PaymentModel> fromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => PaymentModel.fromDocument(doc)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'farmerId': farmerId,
      'farmerName': farmerName,
      'amount': amount,
      'paymentDate': paymentDate,
    };
  }
}
