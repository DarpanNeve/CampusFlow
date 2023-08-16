import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class MyDownloader {
  final String url;

  MyDownloader({required this.url});

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      Directory? downloadsDirectory = await getApplicationDocumentsDirectory();
      String updatedUrl = url.replaceAll("$url/files/", "");
      String fileName =
          updatedUrl; // Change this to specify the file name and extension
      String savePath = '${downloadsDirectory!.path}/$fileName';

      if (!downloadsDirectory.existsSync()) {
        downloadsDirectory.createSync(recursive: true);
      }

      await dio.download(url, savePath);

      if (defaultTargetPlatform == TargetPlatform.android) {
        // Open the file on Android
        await OpenFilex.open(savePath);
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        // Open the file on iOS
        final url = 'file://$savePath';
        await OpenFilex.open(url);
      }
    } catch (e) {
      print(e);
    }
  }
}
