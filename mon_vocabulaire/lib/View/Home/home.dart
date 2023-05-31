import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/View/Games/jeux.dart';
import 'package:mon_vocabulaire/View/Themes/themes.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import '../../Widgets/Appbars/home_app_bar.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  @override
  void dispose() {
    super.dispose();
    AudioBK.pauseBK();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AudioBK.pauseBK();
    } else {
      AudioBK.playBK();
    }
  }

  @override
  void initState() {
    super.initState();
    AudioBK.playBK();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarHome(user: widget.user),
      body: Themes(user: widget.user),
      floatingActionButton: Button(
        callback: () {
          Navigator.of(context).push(
            SlideButtom(page: Games(user: widget.user)),
          );
        },
        content: Row(
          children: const [
            Expanded(
              flex: 20,
              child: Center(
                  child: Text(
                "JOUER",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Icon(
              Icons.gamepad,
              color: Palette.white,
            ),
            Expanded(
              flex: 2,
              child: SizedBox(),
            )
          ],
        ),
        width: 150,
        heigth: 60,
        color: Palette.pink,
      ),
    );
  }
}
