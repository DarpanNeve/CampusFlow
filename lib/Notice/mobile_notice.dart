import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:student/Notice/NoticeModel.dart';
import 'package:student/Notice/upload_notice.dart';
import 'package:student/Widget/Drawer.dart';

import '../main.dart';

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
          return ListView.builder(
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
                        if (roommateDataList[index].docs.toString().isNotEmpty)
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
                    // Text(
                    //     'Switch to typing in a different language with the click of the mouse, and switch back just as easily. The Google Input Tools extension provides virtual keyboards for over 90 languages, full IMEs or direct transliteration for over 30 different scripts, and handwriting input for over 40 languages.'),
                  ],
                ),
              );
            },
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

class ShowNoticePreview extends StatelessWidget {
  const ShowNoticePreview({Key? key, required this.documentUrl})
      : super(key: key);
  final String documentUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
            //add more permission to request here.
          ].request();

          if (statuses[Permission.storage]!.isGranted) {
            // var dir = await DownloadsPathProvider
            //     .downloadsDirectory;
            // if (dir != null) {
            print("permission granted");
            String savename = "new";
            String savePath = "/storage/emulated/0//Download/$savename";
            // print(savePath);
            //output:  /storage/emulated/0/Download/banner.png

            try {
              await Dio().download(documentUrl, savePath,
                  onReceiveProgress: (received, total) {
                if (total != -1) {
                  print("${(received / total * 100).toStringAsFixed(0)}%");
                  //you can build progressbar feature too
                }
              });
              print("File is saved to download folder.");
              OpenFilex.open(savePath);
            } on DioError catch (e) {
              print('${e.message} ok');
            }
            // }
          } else {
            print("No permission to read and write.");
          }
        },
        child: Image.network(
            width: 80, height: 80, "http://117.198.136.16/files/$documentUrl"));
  }
}
