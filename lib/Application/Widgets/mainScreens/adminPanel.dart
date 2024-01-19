import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('report');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports',
          style: titleStyle,
        ),
      ),
      body: StreamBuilder(
        stream: _items.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot itemSnap = snapshot.data.docs[index];
                  return SingleChildScrollView(
                    child: Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  AppText(
                                    txt: 'Name:',
                                    size: 18,
                                  ),
                                  gyap(0, 20),
                                  Text(itemSnap['name']),
                                ],
                              ),
                              Row(
                                children: [
                                  AppText(
                                    txt: 'Email:',
                                    size: 18,
                                  ),
                                  gyap(0, 20),
                                  Text(itemSnap['email']),
                                ],
                              ),
                              Row(
                                children: [
                                  AppText(
                                    txt: 'Report:',
                                    size: 18,
                                  ),
                                  gyap(0, 20),
                                  Text(
                                    itemSnap['incident'],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
