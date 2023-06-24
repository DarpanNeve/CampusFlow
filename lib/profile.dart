import 'package:flutter/material.dart';

import 'Notice/mobile_notice.dart';
import 'TimeTable/mobile_time_table_1.dart';
import 'Widget/Drawer.dart';
import 'firebase_data/auth_service.dart';

class OptionMenuPage extends StatelessWidget {
  final String name;
  final String pRN;
  final String rollNo;
  final String division;
  final String branch;
  final String url;

  const OptionMenuPage(
      {super.key,
      required this.name,
      required this.pRN,
      required this.rollNo,
      required this.division,
      required this.branch,
      required this.url});

  @override
  Widget build(BuildContext context) {
    final List<List> listOfOptions = [
      [
        "Time Table",
        Icons.schedule,
        const MobileTimeTable1(),
      ],
      [
        "Notices",

        Icons.newspaper,
        const MobileNotice(),
      ],
      // [
      //   "Room-mate",
      //   Icons.person_outline,
      //   const MobileFindRoommate(),
      // ],
      // [
      //   "Lost n found",
      //   Icons.search,
      // ],
      // [
      //   "Old Books",
      //   Icons.menu_book_sharp,
      // ],
      // [
      //   "Calender",
      //   Icons.calendar_month_outlined,
      // ],
    ];

    return MaterialApp(
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF81D4FA),
            ),
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const SideDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
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
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.lightBlue.shade200,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Icon(
                          //   Icons.verified_user,
                          //   size: 80,
                          // ),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(url),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(pRN),
                              Text(rollNo),
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
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.00,
                                offset: Offset(0, 5))
                          ],
                          color: const Color.fromRGBO(231, 237, 230, 100),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
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
                          ],
                        ),
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
