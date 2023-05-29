import 'package:flutter/material.dart';
import '../../Widgets/button.dart';

class Choice {
  const Choice({required this.image, required this.color});
  final String image;
  final Color color;
}

const List<Choice> choices = <Choice>[
  Choice(image: 'boy (5)', color: Color.fromARGB(255, 105, 196, 238)),
  Choice(image: 'girl (1)', color: Color.fromARGB(255, 247, 184, 91)),
  Choice(image: 'boy (4)', color: Color.fromARGB(255, 244, 230, 106)),
  Choice(image: 'girl (2)', color: Color.fromARGB(255, 176, 230, 115)),
  Choice(image: 'boy (6)', color: Color.fromARGB(255, 213, 110, 232)),
  Choice(image: 'girl (4)', color: Color.fromARGB(255, 244, 111, 155)),
  // const Choice(image: 'boy (3)', color: Color.fromARGB(255, 234, 93, 83)),
  // const Choice(image: 'girl', color: Color.fromARGB(255, 175, 70, 194)),
];

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Choisir ton avatar ",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: height * 0.7,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
            child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                children: List.generate(choices.length, (index) {
                  final isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: height * 0.15,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/avatars/${choices[index].image}.png")),
                        color: choices[index].color,
                        border: isSelected
                            ? Border.all(width: 5, color: Colors.blue)
                            : Border.all(width: 5, color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(90),
                        ),
                      ),
                      // child: Image.asset(
                      //   "assets/avatars/${widget.choice.image}.png",
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })),
          ),
        ),
        Positioned(
          bottom: 1,
          child: Button(
            callback: () {
              String img = choices.elementAt(selectedIndex).image;
              print(img);
            },
            content: const Text(
              "Enregistrer",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }
}
