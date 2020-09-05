import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final List<dynamic> documentSnapshotList;
  DetailPage({this.documentSnapshot,this.documentSnapshotList});
  final TextStyle style = TextStyle(fontSize: 22,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 4/3,
              child: Card(
                color: Colors.orange[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Name: ${documentSnapshot.data()['name']}',style: style,),
                    Text('Block: ${documentSnapshot.data()['address']['block']}',style: style,),
                    Text('Street: ${documentSnapshot.data()['address']['street']}',style: style,)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height/5,
              child: ListView(
                children: documentSnapshotList.map((list){
                  return Card(
                    color: Colors.blueGrey,
                    child: ListTile(
                      title: Text(list),
                    ),
                  );
                } ).toList()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
