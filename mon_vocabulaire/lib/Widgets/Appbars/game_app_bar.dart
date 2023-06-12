// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class CustomAppBarGames extends StatefulWidget implements PreferredSizeWidget {
  final bool background;
  final Color color;
  final User user;
  final bool timer;
  final Widget widgetCenter;
  const CustomAppBarGames({
    super.key,
    this.background = false,
    this.color = Palette.lightBlue,
    required this.user,
    this.timer = false,
    this.widgetCenter = const SizedBox(),
  });

  @override
  State<CustomAppBarGames> createState() => _CustomAppBarGamesState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100);
}

class _CustomAppBarGamesState extends State<CustomAppBarGames> {
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100);

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  int coins = 0;
  Future<void> getCoins() async {
    DatabaseHelper();
    User _user = await DatabaseHelper().getUser(widget.user.id!);
    setState(() {
      coins = _user.coins;
    });
  }

  @override
  void initState() {
    super.initState();
    getCoins();
  }

  @override
  Widget build(BuildContext context) {
    getCoins();
    return widget.background && !widget.timer
        ? Stack(
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  color: darken(widget.color, .2),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              ),
              Container(
                height: 123,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20),
                    child: Button(
                      callback: () {
                        Navigator.pop(context);
                      },
                      content: const Center(
                          child: Icon(
                        Icons.home_rounded,
                        size: 35,
                        color: Palette.darkGrey,
                      )),
                      width: 55,
                      heigth: 55,
                      radius: 20,
                      color: Palette.white,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: widget.widgetCenter,
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(top: 45, right: 20),
                    child: Container(
                      width: 130,
                      height: 55,
                      decoration: const BoxDecoration(
                          color: Palette.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$coins  ",
                              style: const TextStyle(
                                  color: Palette.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              'assets/images/themes/coin.png',
                              scale: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        : widget.timer
            ? Stack(
                children: [
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      color: darken(widget.color, .2),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                    ),
                  ),
                  Container(
                    height: 103,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 33, left: 20),
                        child: Button(
                          callback: () {
                            Navigator.pop(context);
                          },
                          content: const Center(
                              child: Icon(
                            Icons.home_rounded,
                            size: 35,
                            color: Palette.darkGrey,
                          )),
                          width: 50,
                          heigth: 50,
                          radius: 18,
                          color: Palette.white,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(top: 40, right: 20),
                        child: Container(
                          width: 130,
                          height: 45,
                          decoration: const BoxDecoration(
                              color: Palette.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$coins  ",
                                  style: const TextStyle(
                                      color: Palette.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  'assets/images/themes/coin.png',
                                  scale: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20),
                    child: Button(
                      callback: () {
                        Navigator.pop(context);
                      },
                      content: const Center(
                          child: Icon(
                        Icons.home_rounded,
                        size: 35,
                        color: Palette.darkGrey,
                      )),
                      width: 55,
                      heigth: 55,
                      radius: 20,
                      color: Palette.white,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(top: 35, right: 20),
                    child: Container(
                      width: 130,
                      height: 55,
                      decoration: const BoxDecoration(
                          color: Palette.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$coins  ",
                              style: const TextStyle(
                                  color: Palette.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              'assets/images/themes/coin.png',
                              scale: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
  }
}
