import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'Palette.dart';

class GameBloc extends StatefulWidget {
  final String price;
  final String image;
  final Widget page;
  final bool enabled;
  const GameBloc({
    super.key,
    required this.price,
    required this.image,
    required this.page,
    this.enabled = true,
  });

  @override
  State<GameBloc> createState() => _GameBlocState();
}

class _GameBlocState extends State<GameBloc> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return widget.enabled
        ? Center(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Button(
                    enabled: widget.enabled,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => widget.page,
                        ),
                      );
                    },
                    color: Palette.white,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(child: SizedBox()),
                        Image.asset(
                          widget.image,
                          width: 80,
                        ),
                        const Expanded(child: SizedBox()),
                        Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                widget.price,
                                style: const TextStyle(
                                    color: Palette.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            Image.asset(
                              "assets/images/themes/coin.png",
                              scale: width >= 700
                                  ? 16
                                  : width >= 500
                                      ? 18
                                      : 22,
                            ),
                          ],
                        )),
                        const Expanded(flex: 8, child: SizedBox()),
                      ],
                    ),
                    heigth: 150,
                    width: 150,
                    topRadius: 45,
                    bottomRadius: 70,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Button(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => widget.page,
                        ),
                      );
                    },
                    content: const Center(
                      child: Text(
                        "JOUER",
                        style: TextStyle(
                            color: Palette.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    width: 110,
                    heigth: 55,
                    color: Palette.pink,
                  ),
                )
              ],
            ),
          )
        : Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: Button(
                enabled: widget.enabled,
                callback: () {},
                color: const Color.fromARGB(255, 44, 158, 224),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox()),
                    Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        widget.image,
                        width: 80,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Container(
                      width: 100,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: Palette.indigo,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Opacity(
                          opacity: 0.5,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  widget.price,
                                  style: const TextStyle(
                                      color: Palette.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Image.asset(
                                "assets/images/themes/coin.png",
                                scale: width >= 700
                                    ? 16
                                    : width >= 500
                                        ? 18
                                        : 22,
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                heigth: 150,
                width: 150,
                topRadius: 45,
                bottomRadius: 70,
              ),
            ),
          );
  }
}
