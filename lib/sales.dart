import 'package:cloud_firestore/cloud_firestore.dart';

class Sales {
  final int saleVal;
  final String saleYear;
  final String colorVal;
  final DocumentReference reference;
  Sales(this.saleVal,this.saleYear,this.colorVal,this.reference);

  Sales.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['saleVal'] != null),
        assert(map['saleYear'] != null),
        assert(map['colorVal'] != null),
        saleVal = map['saleVal'],
        colorVal = map['colorVal'],
        saleYear=map['saleYear'];


  Sales.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$saleVal:$saleYear:$colorVal>";
}
