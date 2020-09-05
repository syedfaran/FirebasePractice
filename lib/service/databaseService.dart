import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  DetailPage({this.documentSnapshot});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: ListTile(
          title: Text(documentSnapshot.data()['address']['street']),
          subtitle: Text(documentSnapshot.data()['address']['block']),
        ),
      ),
    );
  }
}
