import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'Model.dart';
import 'package:http/http.dart' as http;


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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            AcdYearsDropdown(),
            SubmitButton(),
            ListData(),
          ],
        ),
      ),
    );
  }
}

class ListData extends StatefulWidget {
  const ListData({Key? key}) : super(key: key);

  @override
  State<ListData> createState() => _ListDataState();
}
class _ListDataState extends State<ListData> {
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                          children: const [
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
          } else {
            return const Text("loading");
          }
        },
      ),
    );
  }
}

class AcdYearsDropdown extends StatefulWidget {
  const AcdYearsDropdown({super.key});

  @override
  State<AcdYearsDropdown> createState() => _AcdYearsDropdownState();
}

class _AcdYearsDropdownState extends State<AcdYearsDropdown> {
  var batchOptions = ["1", "2", "3"];
  var divisionOptions = [""];
  var dayOptions = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
  String? selectedBatch;
  String? selectedDivision;
  String? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.00, vertical: 10.00),
      child: Column(
        children: <Widget>[
          DropdownButton2<String>(
            hint: const Text("Day", style: TextStyle(fontSize: 16)),

            // dropdownMaxHeight: 130,
            isExpanded: true,
            value: selectedDay,
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: dayOptions.map<DropdownMenuItem<String>>((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(
                  val,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedDay = value ?? "";
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: DropdownButton2<String>(
                  hint: const Text("Batch", style: TextStyle(fontSize: 16)),

                  // dropdownMaxHeight: 130,
                  isExpanded: true,
                  value: selectedBatch,
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items:
                      batchOptions.map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(
                        val,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedBatch = value ?? "";
                    });
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: DropdownButton2<String>(
                  hint: const Text("Division", style: TextStyle(fontSize: 16)),

                  //buttonHeight: 40,
                  // dropdownMaxHeight: 130,
                  isExpanded: true,
                  value: selectedDivision,
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: divisionOptions
                      .map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(
                        val,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedDivision = value ?? "";
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SubmitButton extends StatefulWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          setState(() {

          });
        },
        child: const Text("Submit"));
  }
}
