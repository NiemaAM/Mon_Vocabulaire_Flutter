import 'package:flutter/material.dart';
import '../Widgets/Palette.dart';
import '../Widgets/bubble.dart';
import 'lesson_path.dart';

class SubThemes extends StatefulWidget {
  final String title;
  const SubThemes({super.key, required this.title});

  @override
  State<SubThemes> createState() => _SubThemesState();
}

class _SubThemesState extends State<SubThemes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.blue,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            Bubble(
              image: "https://cdn-icons-png.flaticon.com/512/7339/7339480.png",
              isStart: false,
              stage: 60,
              text: 'Mon corps',
              callback: LessonPath(
                title: "Mon corps",
              ),
              color: Palette.purple,
            ),
            Expanded(
              child: SizedBox(),
            ),
            Bubble(
              image: "https://cdn-icons-png.flaticon.com/512/892/892458.png",
              isStart: true,
              stage: 100,
              text: 'Mes habits',
              callback: LessonPath(
                title: "Mes habits",
              ),
              color: Palette.orange,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
