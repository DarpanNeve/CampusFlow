import 'package:flutter/material.dart';
import 'package:student/mobile_time_table.dart';
import 'firebase_data/auth_service.dart';
import 'mobile_notice.dart';

class OptionMenuPage extends StatelessWidget {
  final String studentName = "";

  final String studentDept = "ENTc";
  final String studentRollNo = "SYETB127";
  final int studentYear = 2023;

  const OptionMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List> listOfOptions = [
      [
        "Time Table",
        Icons.schedule,
        const MobileTimeTable(),
      ],
      [
        "Notices",
        Icons.newspaper,
        const MobileNotice(),
      ],
      [
        "Lost n found",
        Icons.search,
      ],
      [
        "Room-mate",
        Icons.person_outline,
      ],
      [
        "Old Books",
        Icons.menu_book_sharp,
      ],
      [
        "Calender",
        Icons.calendar_month_outlined,
      ],

    ];

    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          elevation: 0,
          centerTitle: true,
          title: const Text("Dashboard", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  AuthService().signOut();
                },
                child: const Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.lightBlue.shade300, Colors.white])),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon(
                          //   Icons.verified_user,
                          //   size: 80,
                          // ),
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage("assets/images/googlelogo.png"),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                studentName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const Text("Second Year"),
                              Text(studentDept),
                              Text(studentRollNo),
                            ],
                          )
                        ],
                      )
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 30),
                  itemCount: listOfOptions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => listOfOptions[index][2]),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                listOfOptions[index][1],
                                size: 40,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                listOfOptions[index][0],
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
