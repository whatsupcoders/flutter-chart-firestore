import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final int taskVal;
  final String taskDetails;
  final String colorVal;
  final DocumentReference reference;
  Task(this.taskDetails,this.taskVal,this.colorVal,this.reference);

  Task.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['taskdetails'] != null),
        assert(map['taskVal'] != null),
        assert(map['colorVal'] != null),
        taskDetails = map['taskdetails'],
        taskVal = map['taskVal'],
        colorVal=map['colorVal'];


  Task.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$taskVal:$taskDetails>";
}
