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
          'Reports',
          style: titleStyle,
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
                  //  final DocumentSnapshot itemSnap = snapshot.data.docs[index];
                  Map thisItems = _items[index];
                  return SingleChildScrollView(
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.all(10),
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
                                  : CircleAvatar(),
                            ),
                            Row(
                              children: [
                                AppText(
                                  txt: 'Name:',
                                  size: 18,
                                ),
                                gyap(0, 20),
                                Text('${thisItems['name']}'),
                              ],
                            ),
                            Row(
                              children: [
                                AppText(
                                  txt: 'Email:',
                                  size: 18,
                                ),
                                gyap(0, 20),
                                Text('${thisItems['email'].toString()}'),
                              ],
                            ),
                            Row(
                              children: [
                                AppText(
                                  txt: 'Report:',
                                  size: 18,
                                ),
                                gyap(0, 20),
                                Text('${thisItems['incident']}'),
                              ],
                            ),
                          ],
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
