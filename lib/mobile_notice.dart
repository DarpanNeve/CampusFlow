import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student/roommate_activity/RoommateModel.dart';
import 'package:student/upload_notice.dart';
import 'main.dart';
import 'package:http/http.dart'as http;

class MobileNotice extends StatelessWidget {
  const MobileNotice({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notice",
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UploadBookDetails()),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Notice"),
        ),
        body: Column(
          children: const <Widget>[
              ShowNotices(),
          ],

        ),
      ),
    );
  }
}


class ShowNotices extends StatefulWidget {
  const ShowNotices({Key? key}) : super(key: key);

  @override
  State<ShowNotices> createState() => _ShowNoticesState();
}

class _ShowNoticesState extends State<ShowNotices> {
  List<RoommateModel> roommateDataList=[];

  Future<List<RoommateModel>> getPostApi() async {
    final response=await http.get(Uri.parse("$url/fetch_data_messages.php"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        roommateDataList.add(RoommateModel.fromJson(i));
      }
      print(roommateDataList);
      return roommateDataList;
    } else {
      return roommateDataList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPostApi(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,

            itemCount: roommateDataList.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.lightBlue,
                margin: const EdgeInsetsDirectional.all(5.00),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(roommateDataList[index].docs),
                        ],
                      ),
                    ),
                    Expanded(
                      child:Column(
                        children: [
                          Text(roommateDataList[index].docs),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Text("loading data");
        }
      },
    );
  }
}
