import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/View/Themes/sub_theme_path.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

class SubThemeDonePopup extends StatefulWidget {
  final int subThemeId;
  final User user;

  const SubThemeDonePopup({
    super.key,
    required this.user,
    required this.subThemeId,
  });

  @override
  State<SubThemeDonePopup> createState() => _SubThemeDonePopupState();
}

class _SubThemeDonePopupState extends State<SubThemeDonePopup> {
  @override
  void initState() {
    super.initState();
    Sfx.play("audios/sfx/done.mp3", 1);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.all(width > 500 ? 100 : 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
                    Text(
                      "Terminé !",
                      style: TextStyle(
                          fontSize: width > 500 ? 30 : 25.0,
                          fontWeight: FontWeight.bold,
                          color: Palette.lightGreen),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "Bravo! Tu as terminé cette partie",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: width > 500 ? 20 : 16,
                          color: Palette.black),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Button(
                            callback: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            content: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Palette.white,
                                    size: 20,
                                  ),
                                  Text(
                                    " Retour",
                                    style: TextStyle(
                                        color: Palette.white,
                                        fontSize: width > 500 ? 20 : 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            width: width > 500 ? width / 3.5 : width / 3,
                            color: Palette.lightBlue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Button(
                            callback: () {
                              if (widget.subThemeId < 12) {
                                Navigator.pop(context);
                                Navigator.of(context).pushReplacement(
                                  SlideRight(
                                    page: LessonPath(
                                      subTheme: widget.subThemeId + 1,
                                      user: widget.user,
                                    ),
                                  ),
                                );
                              }
                            },
                            content: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Suivant ",
                                    style: TextStyle(
                                        color: Palette.white,
                                        fontSize: width > 500 ? 20 : 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Palette.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                            width: width > 500 ? width / 3.5 : width / 3,
                            color: Palette.lightGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -65.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: 130.0,
              height: 130.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.white, // Replace with desired color
              ),
              child: Center(
                child: Container(
                  width: 115.0,
                  height: 115.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.lightGreen, // Replace with desired color
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Palette.white,
                      size: 110,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
