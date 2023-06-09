import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
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

  Future<void> calculateResult() async {
    DatabaseHelper();
    int words = await DatabaseHelper().getAllProgression(widget.user.id);
    setState(() {
      _words = words;
    });
  }

  int coins = 0;
  Future<void> getCoins() async {
    DatabaseHelper();
    User _user = await DatabaseHelper().getUser(widget.user.id!);
    setState(() {
      coins = _user.coins;
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    calculateResult();
    getCoins();
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
                  "${coins.toString()} ",
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
              child: Image.asset(widget.user.image),
            ),
            color: Palette.lightBlue,
            heigth: 100,
            width: 100,
          ),
        )
      ],
    );
  }
}
