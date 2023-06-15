// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/View/Account/profil.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';

class CustomAppBarHome extends StatefulWidget implements PreferredSizeWidget {
  final User user;
  const CustomAppBarHome({super.key, required this.user});

  @override
  State<CustomAppBarHome> createState() => _CustomAppBarHomeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100);
}

class _CustomAppBarHomeState extends State<CustomAppBarHome> {
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100);

  bool state = false;

  int _words = 0;
  int coins = 0;
  String image = 'assets/images/avatars/user.png';
  RealtimeDataController controller = RealtimeDataController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> getUser() async {
    await controller.getUser(widget.user.id!);
    User? user = controller.user;
    await controller.getAllWords(widget.user.id!);
    int? totalWords = controller.words;
    setState(() {
      image = user!.image;
      coins = user.coins;
      _words = totalWords!;
    });
  }

  Future<void> volumeState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state) {
      await prefs.setDouble('bkVolume', 0);
      AudioBK.volumeBK(0);
    } else {
      await prefs.setDouble('bkVolume', 0.5);
      AudioBK.volumeBK(0.5);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    getUser();
    return Stack(
      children: [
        const SizedBox(
          height: 130,
        ),
        Container(
          height: 80,
          decoration: const BoxDecoration(
            color: Palette.darkBlue,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        Container(
          height: 73,
          decoration: const BoxDecoration(
            color: Palette.lightBlue,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Palette.darkBlue,
            title: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Text(
                  coins < 999 ? "${coins.toString()} " : "999 ",
                  style: const TextStyle(
                      color: Palette.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  'assets/images/themes/coin.png',
                  scale: 20,
                ),
                LinearPercentIndicator(
                  width: width - 180,
                  animation: true,
                  lineHeight: 25.0,
                  animationDuration: 1000,
                  percent: _words / 240,
                  barRadius: const Radius.circular(100),
                  progressColor: Palette.lightGreen,
                  backgroundColor: Palette.darkBlue,
                  center: Text(
                    "$_words sur 240 mots",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      state = !state;
                    });
                    volumeState();
                  },
                  icon: Icon(
                    state ? Icons.volume_off_rounded : Icons.volume_up,
                    color: Palette.darkGrey,
                    size: 30,
                  )),
            )),
        Positioned(
          top: 12,
          child: Button(
            callback: () {
              Navigator.of(context).push(
                SlideTop(page: Profil(user: widget.user)),
              );
            },
            content: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: image.startsWith("assets")
                      ? Image.asset(image)
                      : Image.file(
                          File(image),
                          fit: BoxFit.cover,
                          width: width / 2.5,
                          height: width / 2.5,
                        ),
                )),
            color: Palette.lightBlue,
            heigth: 100,
            width: 100,
          ),
        )
      ],
    );
  }
}
