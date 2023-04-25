import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student/Notice/NoticeModel.dart';
import 'package:student/Notice/upload_notice.dart';
import 'package:student/Widget/Drawer.dart';

import '../main.dart';
import 'download.dart';

class MobileNotice extends StatelessWidget {
  const MobileNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notice",
      home: Scaffold(
        drawer: const SideDrawer(),
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
  List<NoticeModel> roommateDataList = [];

  Future<List<NoticeModel>> getPostApi() async {
    final response = await http.get(Uri.parse("$url/fetch_data_messages.php"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        roommateDataList.add(NoticeModel.fromJson(i));
      }
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
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: roommateDataList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.purple.shade100),
                  margin: const EdgeInsetsDirectional.all(5.00),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                roommateDataList[index].name.toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Rubik'),
                              ),
                              Text(
                                roommateDataList[index].timestamp.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'Rubik'),
                              ),
                            ],
                          ),
                          if (roommateDataList[index]
                              .docs
                              .toString()
                              .isNotEmpty)
                            ShowNoticePreview(
                                documentUrl:
                                    roommateDataList[index].docs.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(roommateDataList[index].title.toString()),
                      Text(roommateDataList[index].message.toString()),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ShowNoticePreview extends StatefulWidget {
  const ShowNoticePreview({Key? key, required this.documentUrl})
      : super(key: key);
  final String documentUrl;

  @override
  State<ShowNoticePreview> createState() => _ShowNoticePreviewState();
}

class _ShowNoticePreviewState extends State<ShowNoticePreview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyDownloader(url: "$url/files/${widget.documentUrl}").downloadFile();
      },
      child: Column(
        children: <Widget>[
          if (widget.documentUrl.contains(".jpeg") ||
              widget.documentUrl.contains(".jpg") ||
              widget.documentUrl.contains(".png") ||
              widget.documentUrl.contains(".gif")) ...[
            const Icon(Icons.image_rounded),
          ] else if (widget.documentUrl.contains(".pdf")) ...[
            const Icon(Icons.picture_as_pdf),
          ] else if (widget.documentUrl.contains(".txt")) ...[
            const Icon(Icons.description),
          ] else if (widget.documentUrl.contains(".xlsx")) ...[
            const Icon(Icons.table_chart),
          ] else if (widget.documentUrl.contains(".doc") ||
              widget.documentUrl.contains(".docx")) ...[
            const Icon(Icons.article),
          ] else ...[
            const Icon(Icons.error)
          ]
        ],
      ),
    );
  }
}
