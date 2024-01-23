import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  void deleteReport(docId) {
    _items.doc(docId).delete();
  }

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('report');
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = _items.snapshots(); // Initialize the stream here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel  \nReports of incidents',
          style: appBartitleStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('some error occured${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> document = querySnapshot.docs;

            List<Map> _items = document.map((e) => e.data() as Map).toList();

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot itemSnap = snapshot.data.docs[index];
                  Map thisItems = _items[index];
                  return SingleChildScrollView(
                    child: Slidable(
                      startActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            deleteReport(itemSnap.id);
                          }),
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                        ),
                      ]),
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                child: thisItems.containsKey('image')
                                    ? ClipOval(
                                        child: Image.network(
                                          '${thisItems['image']}',
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        ),
                                      )
                                    : const CircleAvatar(),
                              ),
                              Row(
                                children: [
                                  AppText(
                                    txt: 'Name:',
                                    size: 15,
                                    fw: FontWeight.bold,
                                  ),
                                  gyap(0, 20),
                                  Expanded(
                                    child: Text(
                                      '${thisItems['name']}',
                                      style: smallTexts,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AppText(
                                    txt: 'Email:',
                                    size: 15,
                                    fw: FontWeight.bold,
                                  ),
                                  gyap(0, 20),
                                  Expanded(
                                    child: Text(
                                      '${thisItems['email'].toString()}',
                                      style: smallTexts,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AppText(
                                    txt: 'Location:',
                                    size: 15,
                                    fw: FontWeight.bold,
                                  ),
                                  gyap(0, 20),
                                  Expanded(
                                    child: Text(
                                      '${thisItems['location'].toString()}',
                                      style: smallTexts,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AppText(
                                    txt: 'Value:',
                                    size: 15,
                                    fw: FontWeight.bold,
                                  ),
                                  gyap(0, 20),
                                  Expanded(
                                    child: Text(
                                      '${thisItems['value'].toString()}',
                                      style: smallTexts,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AppText(
                                    txt: 'Report:',
                                    size: 15,
                                    fw: FontWeight.bold,
                                  ),
                                  gyap(0, 20),
                                  Expanded(
                                    child: Text(
                                      '${thisItems['incident']}',
                                      style: smallTexts,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
