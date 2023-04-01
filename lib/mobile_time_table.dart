

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'fetch_data.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            AcdYearsDropdown(),
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


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("loading");
          } else {
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
  var listOfOptions = ["A", "S.Y.", "T.Y.", "B.E."];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.00, vertical: 20.00),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton2<String>(
            hint: const Text("Division", style: TextStyle(fontSize: 16)),

            buttonHeight: 40,
            // dropdownMaxHeight: 130,
            // isExpanded: true,
            value: selectedValue,
            buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black)),
            items: listOfOptions.map<DropdownMenuItem<String>>((String val) {
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
                selectedValue = value ?? "";
              });
            },
          ),
          DropdownButton2<String>(
            hint: const Text("Batch", style: TextStyle(fontSize: 16)),

            buttonHeight: 40,
            // dropdownMaxHeight: 130,
            // isExpanded: true,
            value: selectedValue,
            buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black)),
            items: listOfOptions.map<DropdownMenuItem<String>>((String val) {
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
                selectedValue = value ?? "";
              });
            },
          ),
        ],
      ),
    );
  }
}
