import 'package:flutter/material.dart';
import 'package:student/roommate_activity/upload_find_roommate.dart';

class MobileFIndRoommate extends StatelessWidget {
  const MobileFIndRoommate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finding Roommate',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UploadFindRoommate()),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder(
              future: null,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: null,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.lightBlue,
                        margin: const EdgeInsetsDirectional.all(5.00),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: const [
                                  Text("Start:"),
                                  Text("End:"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Text("loading");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
