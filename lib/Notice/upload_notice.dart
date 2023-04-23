import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student/firebase_data/auth_service.dart';
import 'package:student/main.dart';

import '../Widget/borderTextField.dart';

class UploadBookDetails extends StatefulWidget {
  const UploadBookDetails({super.key});

  @override
  State<UploadBookDetails> createState() => _UploadBookDetailsState();
}

class _UploadBookDetailsState extends State<UploadBookDetails> {
  String filename = "";
  late int fileCode;
  final subjectController = TextEditingController();
  final titleController = TextEditingController();
  File? pickedFile;
  FilePickerResult? filePickerResult;
  double _progress = 0;

  Future<void> _uploadFile() async {
    if (pickedFile == null) {
      print('Selected file is null');
      sendInfoToMySql(
          userName, titleController.text, subjectController.text, filename);
      return;
    }
    //initialising dio
    Dio dio = Dio();
    setState(
      () {
        fileCode = Random().nextInt(999999);
        filename = "$fileCode${filePickerResult!.files.single.name}";
        filename = filename.replaceAll(" ", "");
      },
    );
    print(filePickerResult?.paths.toString());
    FormData formData = FormData.fromMap(
      {
        'file':
            await MultipartFile.fromFile(pickedFile!.path, filename: filename),
      },
    );

    // Send the request
    try {
      //var response = await request.send();
      Response response = await dio.post(
        'http://117.198.136.16/upload.php',
        data: formData,
        onSendProgress: (int sent, int total) {
          setState(
            () {
              _progress = (sent / total);
            },
          );
          print('Upload progress: $_progress');
        },
      );

      // Check the response
      if (response.statusCode == 200) {
        var responseJson = json.encode(response.data);
        var responseData = json.decode(responseJson);
        if (responseData['status'] == 'success') {
          sendInfoToMySql(userName, titleController.text.toString(),
              subjectController.value.toString(), filename);
          print('File uploaded successfully!');
        } else {
          print('File upload failed: ${responseData['message']}');
        }
      } else {
        print('File upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('File upload failed: $e');
    }
  }

  Future<void> _openFileExplorer() async {
    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (filePickerResult != null) {
      setState(() {
        pickedFile = File(filePickerResult!.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                ))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Upload Notice",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                          fontSize: 17),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Upload Notice",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            fontFamily: 'Rubik'),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _openFileExplorer();
                            },
                            icon: const Icon(
                              Icons.attach_file_outlined,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _uploadFile();
                            },
                            icon: const Icon(
                              Icons.arrow_circle_up_rounded,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BorderedTextField(
                    maxContentLines: 1,
                    hintText: "Title of Notice",
                    labelText: "Title",
                    fieldController: titleController),
                BorderedTextField(
                    maxContentLines: 15,
                    hintText: "Details",
                    labelText: "Message",
                    fieldController: subjectController),
                const SizedBox(height: 16.0),
                if (_progress > 0)
                  LinearProgressIndicator(
                    value: _progress,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendInfoToMySql(
      String name, String title, String message, String docs) async {
    try {

      //var response = await request.send();
      final uploadResponse = await http.post(
        Uri.parse("$url/upload_data_messages.php"),
        body: {
          "Name": name,
          "Title": title,
          "Message": message,
          "Docs": docs,
        },
      );
      // Check the response
      if (uploadResponse.statusCode == 200) {
        print(uploadResponse.body.toString());
        print('message uploaded successfully!');
      } else {
        print('message upload failed with status code ${uploadResponse.statusCode}');
      }
    } catch (e) {
      print('message upload failed: $e');
    }
  }
}
