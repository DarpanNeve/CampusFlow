import 'dart:convert';

import 'package:student/Model.dart';
import 'package:http/http.dart' as http;



List<Model> postList = [];
String url = "http://117.198.136.16/fetch_input.php";
Future<List<Model>> getPostApi() async {
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