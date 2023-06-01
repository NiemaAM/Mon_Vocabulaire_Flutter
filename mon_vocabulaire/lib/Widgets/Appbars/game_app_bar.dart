import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class CustomAppBarGames extends StatefulWidget implements PreferredSizeWidget {
  final bool background;
  final Color color;
  final User user;
  const CustomAppBarGames({
    super.key,
    this.background = false,
    this.color = Palette.lightBlue,
    required this.user,
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

  @override
  Widget build(BuildContext context) {
    return widget.background
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
                              "${widget.user.coins}  ",
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
                          "${widget.user.coins}  ",
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