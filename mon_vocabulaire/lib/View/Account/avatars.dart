import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/app_bar.dart';

class Avatars extends StatefulWidget {
  const Avatars({super.key});

  @override
  State<Avatars> createState() => _AvatarsState();
}

class _AvatarsState extends State<Avatars> {
  List<String> imagePaths = [
    'assets/images/avatars/boy1.png',
    'assets/images/avatars/girl1.png',
    'assets/images/avatars/boy2.png',
    'assets/images/avatars/girl2.png',
    'assets/images/avatars/boy3.png',
    'assets/images/avatars/girl3.png',
    'assets/images/avatars/boy4.png',
    'assets/images/avatars/girl4.png',
  ];

  String selectedImagePath = 'assets/images/avatars/avatar_boy.png';

  @override
  Widget build(BuildContext context) {
    void selectAvatar(BuildContext context, String image) {
      Navigator.pop(context, image);
    }

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "MA PHOTO",
        color: Palette.lightBlue,
        automaticallyImplyLeading: true,
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: width > 500 ? 2 : 1.4,
              children: imagePaths.map((imagePath) {
                return GestureDetector(
                  onTap: () {
                    // Handle the tap event here
                    setState(() {
                      selectedImagePath = imagePath;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedImagePath == imagePath
                                    ? Palette.pink
                                    : Colors.transparent,
                                width: 5,
                              ),
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                              )),
                          child: Padding(
                            padding: EdgeInsets.all(width > 500 ? 0 : 8.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedImagePath == imagePath
                                        ? Palette.white
                                        : Colors.transparent,
                                  ),
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    size: 30,
                                    color: selectedImagePath == imagePath
                                        ? Palette.pink
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Button(
                color: Palette.lightBlue,
                width: 180,
                callback: () {
                  selectAvatar(context, selectedImagePath);
                },
                content: const Center(
                    child: Text(
                  "CHOISIR",
                  style: TextStyle(
                      color: Palette.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text("Mon Vocabulaire",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Palette.lightBlue)),
          ),
        )
      ]),
    );
  }
}
