import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/service/databaseService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    // CollectionReference one = FirebaseFirestore.instance.collection('UserInfo');
    // DocumentReference two = FirebaseFirestore.instance.collection('UserInfo').doc();
    // Future<QuerySnapshot> three = FirebaseFirestore.instance.collection('UserInfo').get();
    // Future<DocumentReference> four = FirebaseFirestore.instance.collection('UserInfo').add({
    //   'name':'Faran',
    // });
    // Future<void> five = FirebaseFirestore.instance.collection('UserInfo').doc('UserOne').set({
    //   'name':'Ali'
    // });
    // Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
    // Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('UserInfo')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Loading'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (_, index) {
                        return Card(
                          color: Colors.amberAccent,
                          child: ListTile(
                            dense: true,
                            title:
                                Text(snapshot.data.docs[index].data()['name']),
                            leading: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('UserInfo')
                                    .add({'name': 'Qunoot'});
                                FirebaseFirestore.instance
                                    .collection('UserInfo')
                                    .doc('Special Member')
                                    .set({
                                  'name': '*****',
                                });
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('UserInfo')
                                    .doc(snapshot.data.docs[index].id)
                                    .delete();
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('NetNinja')
                      .get()
                      .then((snapshot) {
                    snapshot.docs.forEach((doc) {
                      print(doc.data()['name']);
                      print(doc.data()['address']['street']);
                    });
                  }),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('Loading'),
                      );
                    } else {
                      return Text(snapshot.data);
                    }
                  }),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: FutureBuilder<QuerySnapshot>(
                  future:
                      FirebaseFirestore.instance.collection('NetNinja').get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('Loading'),
                      );
                    } else {
                      return ListView(
                        children: snapshot.data.docs.map((queryDocumentSnapshot){
                          return Card(
                            color: Colors.orange[50],
                            child: ListTile(
                              title: Text(queryDocumentSnapshot.data()['name']),
                              subtitle: Text(queryDocumentSnapshot.id),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>DetailPage(
                                    documentSnapshotList: queryDocumentSnapshot.data()['children'],
                                    documentSnapshot: queryDocumentSnapshot,
                                  ),
                                ));
                              },
                            ),
                          );
                        }).toList(),
                      );
                    }
                  }),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: FutureBuilder<QuerySnapshot>(
                  future:
                      FirebaseFirestore.instance.collection('UserInfo').get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('Loading'),
                      );
                    } else {
                      return ListView(
                        children:
                            snapshot.data.docs.map((queryDocumentSnapShot) {
                          return Card(
                            child: ListTile(
                              title: Text(queryDocumentSnapShot.data()['name']),
                              subtitle: Text(queryDocumentSnapShot.id),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('NetNinja').get(),

                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('Loading'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (_,index){
                          return Text(snapshot.data.docs[index].data().toString());
                        },
                      );
                    }
                  }),
            ),
          ),

        ],
      ),
    );
  }
}

