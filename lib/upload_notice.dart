import 'package:flutter/material.dart';

import 'borderTextField.dart';

class UploadBookDetails extends StatefulWidget {

  const UploadBookDetails({super.key});

  @override
  State<UploadBookDetails> createState() => _UploadBookDetailsState();
}

class _UploadBookDetailsState extends State<UploadBookDetails> {
  TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        // centerTitle: true,
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
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_circle_up_rounded,
                            color: Colors.blue,
                            size: 40,
                          ))
                    ],
                  ),
                ),
                BorderedTextField(
                    maxContentLines: 1,
                    hintText: "Subject: Subject of the book",
                    labelText: "Subject",
                    fieldController: subjectController),
                BorderedTextField(
                    maxContentLines: 15,
                    hintText: "Details about the book",
                    labelText: "Book Details",
                    fieldController: subjectController),
              ]),
        ),
      ),
    );
  }
}