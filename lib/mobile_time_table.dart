import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student/Model.dart';

class MobileTimeTable extends StatelessWidget {
  const MobileTimeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Table",
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back, color: Colors.black),
          title: const Text(
            "Time Table",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            listdata(),
          ],
        ),

      ),
    );
  }
}

class listdata extends StatefulWidget {
  const listdata({Key? key}) : super(key: key);

  @override
  State<listdata> createState() => _listdataState();
}

class _listdataState extends State<listdata> {
  List<Model> postList = [];
  String url="http://117.198.136.16/fetch_input.php";

  Future<List<Model>> getPostApi() async {
    print("Hello");
    final response = await http.post(Uri.parse(url), body: {
      "Day": "Monday",
      "Division": "A",
      "Batch": "1",
    });
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(Model.fromJson(i));
      }

      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("loading");
          } else {
            return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.lightBlue,
                  margin: const EdgeInsetsDirectional.all(5.00),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children:const [
                            Text("Start:"),
                            Text("End:"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(postList[index].start),
                            Text(postList[index].end),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(postList[index].subject),
                            Text(postList[index].classroom),
                            Text(postList[index].teacher),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
