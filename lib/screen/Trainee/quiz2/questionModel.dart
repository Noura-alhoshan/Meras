import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class test {
  String q;
//  String o1;
//  String o2;
/////  String o3;
  // String o4;
  String o5;
  Map mm;
  String textQ;
  String id;
  Timestamp ts;
  bool TF;
  test(this.q, this.o5, this.mm, this.textQ, this.TF, this.id, this.ts);

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        'q': q,
        //   'o1': o1,
        //    'o2': o2,
        //    'o3': o3,
        //    'o4': o4,
        'o5': o5,
        'mm': mm,
        'textQ': textQ,
        'ts': ts,
        'TF': TF,
        'id': id
      };

  // creating a Trip object from a firebase snapshot
  test.fromSnapshot(DocumentSnapshot snapshot)
      : q = snapshot['imageUrl'],
        //   o1 = snapshot['o1'],
        //  o2 = snapshot['o2'],
        //  o3 = snapshot['o3'],
        //  o4 = snapshot['o4'],
        o5 = snapshot['answer'],
        mm = snapshot['options'],
        textQ = snapshot['question'],
        ts = snapshot['createdAt'],
        TF = snapshot['isTnFType'],
        id = snapshot['id'];
}
