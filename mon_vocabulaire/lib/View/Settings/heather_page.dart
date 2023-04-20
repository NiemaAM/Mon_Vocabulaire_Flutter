import 'package:flutter/material.dart';
//import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mon_vocabulaire/Widgets/icon_widget.dart';

class HeaderPage extends StatelessWidget {
  static const keyDarkMode = 'key-dark-mode';

/*  Widget buildDarkMode() => SwitchSettingsTile(
        settingKey: keyDarkMode,
        leading: IconWidget(icon: Icons.dark_mode, color: Color(0xFF170635)),
        title: 'Mode Sombre',
        onChange: (isDarkMode) {/* Noop*/},
      );*/

  Widget buildUser() {
    String url = "https://cdn.pixabay.com/2016/03/29/03/14/portait-1287421_";
    return Center(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(url),
        ),
        title: Text("Salma"),
        subtitle: Text("Niveau 1"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          buildUser(),
          const SizedBox(
            height: 32,
          ),
          // buildDarkMode(),
        ],
      );
}
