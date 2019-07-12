import 'package:cloud_firestore/cloud_firestore.dart';

class Weather {
  final int max;
  final int min;
  final String day;
  final String colorVal;
  final DocumentReference reference;
  Weather(this.max,this.min,this.day,this.colorVal,this.reference);
  Weather.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['max'] != null),
        assert(map['min'] != null),
        assert(map['day'] != null),
        max = map['max'],
        min = map['min'],
        day = map['day'],
        colorVal=map['colorVal'];


  Weather.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$max:$min:$day>";
}
