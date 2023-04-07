import 'package:flutter/material.dart';

import 'Model.dart';
class MobileNotice extends StatelessWidget {
  const MobileNotice({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notice",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("data"),
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
  List<Model> roomateDataList=[];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      return null;


    },);
  }
}
