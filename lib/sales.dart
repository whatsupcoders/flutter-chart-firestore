import 'package:cloud_firestore/cloud_firestore.dart';

class Sales {
  final int saleVal;
  final String saleYear;
  final DocumentReference reference;
  Sales(this.saleVal,this.saleYear,this.reference);

  Sales.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['saleVal'] != null),
        assert(map['saleYear'] != null),
        saleVal = map['saleVal'],
        saleYear=map['saleYear'];


  Sales.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$saleVal:$saleYear>";
}
