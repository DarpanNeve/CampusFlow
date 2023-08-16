import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student/Notice/NoticeModel.dart';
import 'package:student/Notice/upload_notice.dart';
import 'package:student/Widget/Drawer.dart';

import '../main.dart';
import 'download.dart';

class MobileNotice extends StatefulWidget {
  const MobileNotice({Key? key}) : super(key: key);

  @override
  State<MobileNotice> createState() => _MobileNoticeState();
}

class _MobileNoticeState extends State<MobileNotice> {
  List<NoticeModel> roommateDataList = [];

  void _refreshNotices() async {
    setState(() {
      roommateDataList.clear();
    });
  }

  Future<List<NoticeModel>> _getPostApi() async {
    final response = await http.get(Uri.parse("$url/fetch_notice.php"));
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
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF81D4FA),
            ),
      ),
      title: "Notice",
      home: Scaffold(
        drawer: const SideDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UploadBookDetails(
                  onUploaded: _refreshNotices,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text("Notice", style: TextStyle(color: Colors.black)),
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder(
              future: _getPostApi(),
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
                              color: Colors.lightBlue.shade200),
                          margin: const EdgeInsetsDirectional.all(5.00),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        roommateDataList[index]
                                            .timestamp
                                            .toString(),
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
                                        documentUrl: roommateDataList[index]
                                            .docs
                                            .toString()),
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
            ),
          ],
        ),
      ),
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
