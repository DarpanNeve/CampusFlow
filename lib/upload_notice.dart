import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'borderTextField.dart';

class UploadBookDetails extends StatefulWidget {
  const UploadBookDetails({super.key});

  @override
  State<UploadBookDetails> createState() => _UploadBookDetailsState();
}

class _UploadBookDetailsState extends State<UploadBookDetails> {
  final subjectController = TextEditingController();
  File? pickedFile;
  FilePickerResult? filePickerResult;
  double _progress = 0;

  Future<void> _uploadFile() async {
    if (pickedFile == null) {
      print('Selected file is null');
      return;
    }
    //initialising dio
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(pickedFile!.path,
          filename: filePickerResult!.files.single.name),
    });

    // Send the request
    try {
      //var response = await request.send();
      Response response = await dio.post(
        'http://117.198.136.16/upload.php',
        data: formData,
        onSendProgress: (int sent, int total) {
          setState(() {
            _progress = (sent / total);
          });
          print('Upload progress: $_progress');
        },
      );

      // Check the response
      if (response.statusCode == 200) {
        var responseJson = await response.data;
        var responseData = json.decode(responseJson);
        if (responseData['status'] == 'success') {

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
            "Old Books",
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
                        "Sell Your Old Book",
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
                    fieldController: subjectController),
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
}
