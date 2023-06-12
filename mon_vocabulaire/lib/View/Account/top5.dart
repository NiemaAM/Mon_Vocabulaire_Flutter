// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/app_bar.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class Top5 extends StatefulWidget {
  const Top5({super.key});

  @override
  State<Top5> createState() => _Top5State();
}

class _Top5State extends State<Top5> {
  List<String> images = [
    "assets/images/avatars/user.png",
    "assets/images/avatars/user.png",
    "assets/images/avatars/user.png",
    "assets/images/avatars/user.png",
    "assets/images/avatars/user.png"
  ];
  List<String> names = ["", "", "", "", ""];
  List<String> lvls = ["", "", "", "", ""];
  List<int> stars = [0, 0, 0, 0, 0];
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Fetch users when the widget is initialized
  }

  Future<void> fetchUsers() async {
    // Fetch users from the database
    List<User> fetchedUsers = await DatabaseHelper().getUsersTop5();

    setState(() {
      users = fetchedUsers;
      for (int i = 0; i < fetchedUsers.length; i++) {
        names[i] = fetchedUsers[i].name;
        images[i] = fetchedUsers[i].image;
        lvls[i] = "Niveau ${fetchedUsers[i].currentLevel}";
      }
    });

    List<int> _stars = [];
    for (int i = 0; i < users.length; i++) {
      int userStars = await DatabaseHelper().getStars(users[i].id);
      _stars.add(userStars);
    }
    setState(() {
      stars[0] = _stars[0];
      stars[1] = _stars[1];
      stars[2] = _stars[2];
      stars[3] = _stars[3];
      stars[4] = _stars[4];
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    fetchUsers();
    return Scaffold(
      appBar: CustomAppBar(
        title: "TOP5",
        color: Palette.lightBlue,
        automaticallyImplyLeading: true,
        icon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_rounded),
            enableFeedback: false,
            isSelected: false),
      ),
      body: Stack(children: [
        Stack(children: [
          Align(
              alignment: AlignmentDirectional.bottomEnd,
              child:
                  Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                Container(
                  height: width > 400 ? height / 3 : height / 3,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Palette.lightBlue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100)),
                  ),
                ),
              ])),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      width: 550,
                      height: 550,
                      child: Stack(alignment: Alignment.center, children: [
                        Positioned(
                          top: width > 400 ? height / 4.7 : height / 5,
                          left: width > 500 ? 75 : 5,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Palette.yellow,
                                      ),
                                      Text(
                                        stars[1].toString(),
                                        style: const TextStyle(
                                            color: Palette.yellow,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width > 500 ? 140 : 120,
                                  height: width > 500 ? 140 : 120,
                                  decoration: const BoxDecoration(
                                    color: Palette.lightBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Palette.white,
                                              width: 3,
                                            ),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(images[1]),
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    names[1],
                                    style: const TextStyle(
                                      color: Palette.indigo,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    lvls[1],
                                    style: const TextStyle(
                                      color: Palette.lightBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Positioned(
                          top: width > 400 ? height / 4.7 : height / 5,
                          right: width > 500 ? 75 : 5,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Palette.yellow,
                                      ),
                                      Text(
                                        stars[2].toString(),
                                        style: const TextStyle(
                                            color: Palette.yellow,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width > 500 ? 140 : 120,
                                  height: width > 500 ? 140 : 120,
                                  decoration: const BoxDecoration(
                                    color: Palette.lightBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Palette.white,
                                              width: 3,
                                            ),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(images[2]),
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    names[2],
                                    style: const TextStyle(
                                      color: Palette.indigo,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    lvls[2],
                                    style: const TextStyle(
                                      color: Palette.lightBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Positioned(
                          top: 0,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Palette.yellow,
                                      ),
                                      Text(
                                        stars[0].toString(),
                                        style: const TextStyle(
                                            color: Palette.yellow,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/levels/crown.png',
                                  fit: BoxFit.cover,
                                  width: 70,
                                ),
                                Container(
                                  width: width > 200 ? 160 : 120,
                                  height: width > 200 ? 160 : 120,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 223, 82),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Palette.pink,
                                              width: 5,
                                            ),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                images[0],
                                              ),
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    names[0],
                                    style: const TextStyle(
                                      color: Palette.indigo,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    lvls[0],
                                    style: const TextStyle(
                                      color: Palette.lightBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ]))
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 210,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            flex: 5,
                            child: SizedBox(),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Palette.yellow,
                              ),
                              Text(
                                stars[3].toString(),
                                style: const TextStyle(
                                    color: Palette.yellow,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: width - 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Palette.white.withOpacity(0.6),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                              ),
                              child: Center(
                                  child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 70,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Palette.lightBlue,
                                          border: Border.all(
                                            color: Palette.lightBlue,
                                            width: 3,
                                          ),
                                          image: DecorationImage(
                                              image: AssetImage(images[3]))),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        names[3],
                                        style: const TextStyle(
                                            color: Palette.indigo,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        lvls[3],
                                        style: const TextStyle(
                                            color: Palette.lightBlue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Expanded(
                                    flex: 2,
                                    child: SizedBox(),
                                  ),
                                ],
                              )),
                            ),
                          ),
                          const Expanded(
                            flex: 5,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            flex: 5,
                            child: SizedBox(),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Palette.yellow,
                              ),
                              Text(
                                stars[4].toString(),
                                style: const TextStyle(
                                    color: Palette.yellow,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: width - 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Palette.white.withOpacity(0.6),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                              ),
                              child: Center(
                                  child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 70,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Palette.lightBlue,
                                          border: Border.all(
                                            color: Palette.lightBlue,
                                            width: 3,
                                          ),
                                          image: DecorationImage(
                                              image: AssetImage(images[4]))),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        names[4],
                                        style: const TextStyle(
                                            color: Palette.indigo,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        lvls[4],
                                        style: const TextStyle(
                                            color: Palette.lightBlue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Expanded(
                                    flex: 2,
                                    child: SizedBox(),
                                  ),
                                ],
                              )),
                            ),
                          ),
                          const Expanded(
                            flex: 5,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ]),
      ]),
    );
  }
}
