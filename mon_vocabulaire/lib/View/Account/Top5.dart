import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class Top5 extends StatefulWidget {
  const Top5({super.key});

  @override
  State<Top5> createState() => _Top5State();
}

class _Top5State extends State<Top5> {
  String imagePaths = 'assets/images/avatars/boy1.png';

  String selectedImagePath = 'assets/images/avatars/avatar_boy.png';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.blue,
        elevation: 0,
        title: Text("TOP"),
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
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100)),
                  ),
                ),
              ])),
          Center(
            child: Column(
              children: [
                Stack(
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
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 220, 106),
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                    width: 50,
                                  ),
                                  Container(
                                    width: width > 500 ? 140 : 120,
                                    height: width > 500 ? 140 : 120,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Palette.lightBlue,
                                          width: 4,
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/images/avatars/boy3.png',
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
                                    'MEHDI',
                                    style: TextStyle(
                                      color: Palette.lightBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'LVL2',
                                    style: TextStyle(
                                      color: Palette.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                          ),
                          Positioned(
                            top: width > 400 ? height / 4.7 : height / 5,
                            right: width > 500 ? 75 : 5,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 220, 106),
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                    width: 50,
                                  ),
                                  Container(
                                    width: width > 500 ? 140 : 120,
                                    height: width > 500 ? 140 : 120,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Palette.lightBlue,
                                          width: 4,
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/images/avatars/boy2.png',
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
                                    'AHMAD',
                                    style: TextStyle(
                                      color: Palette.lightBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'LVL1',
                                    style: TextStyle(
                                      color: Palette.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                          Positioned(
                            top: height * 0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width > 400 ? 150 : 100,
                                    height: width > 400 ? 150 : 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Expanded(
                                          flex: 40,
                                          child: SizedBox(),
                                        ),
                                        const Text(
                                          '1',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 220, 106),
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        Image.asset(
                                          'assets/images/levels/couronne.png',
                                          fit: BoxFit.cover,
                                          width: 70,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Container(
                                    width: width > 200 ? 160 : 120,
                                    height: width > 200 ? 160 : 120,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 223, 82),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Palette.pink,
                                          width: 5,
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/images/avatars/girl1.png',
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
                                    'SALMA',
                                    style: TextStyle(
                                      color: Palette.lightBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'LVL2',
                                    style: TextStyle(
                                      color: Palette.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ]),
                          ),
                        ]))
                  ],
                )
              ],
            ),
          ),
        ]),
        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: SizedBox(
            height: height / 2.6,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    Row(children: [
                      const Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width > 400 ? 110 : 73),
                        child: const Text(
                          "4",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 220, 106),
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width > 400 ? 110 : 73),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Palette.lightBlue,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                            color: Color.fromARGB(255, 183, 237, 244),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100),
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100)),
                          ),
                          child: Container(
                              width: width > 400 ? 375 : 270,
                              height: width > 400 ? 55 : 50,
                              margin: EdgeInsets.all(5),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Image.asset(
                                        'assets/images/avatars/girl2.png',
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: SizedBox(),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 2),
                                        child: Column(
                                          children: const [
                                            Text(
                                              "Khawla",
                                              style: TextStyle(
                                                color: Palette.blue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Text(
                                                "LVL 1",
                                                style: TextStyle(
                                                    color: Palette.blue,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )),
                                    const Expanded(
                                      flex: 2,
                                      child: SizedBox(),
                                    ),
                                  ])),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                    ]),
                    Row(children: [
                      const Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width > 400 ? 40 : 10),
                        child: const Text(
                          "5",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 220, 106),
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width > 400 ? 40 : 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Palette.lightBlue,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                            color: Color.fromARGB(255, 183, 237, 244),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100),
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100)),
                          ),
                          child: Container(
                              width: width > 500 ? 375 : 270,
                              height: width > 500 ? 55 : 50,
                              margin: EdgeInsets.all(5),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Image.asset(
                                          'assets/images/avatars/boy1.png'),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: SizedBox(),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 2),
                                        child: Column(
                                          children: const [
                                            Text(
                                              "Mouad",
                                              style: TextStyle(
                                                color: Palette.blue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Text(
                                                "LVL 1",
                                                style: TextStyle(
                                                    color: Palette.blue,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )),
                                    const Expanded(
                                      flex: 2,
                                      child: SizedBox(),
                                    ),
                                  ])),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                    ]),
                  ],
                )),
          ),
        ),
      ]),
    );
  }
}
