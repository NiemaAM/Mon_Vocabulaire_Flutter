import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mon_vocabulaire/Widgets/icon_widget.dart';

class HeaderPage extends StatelessWidget {
  static const keyDarkMode = 'key-dark-mode';

  Widget buildDarkMode() => SwitchSettingsTile(
        settingKey: keyDarkMode,
        leading: IconWidget(icon: Icons.dark_mode, color: Color(0xFF170635)),
        title: 'Mode Sombre',
        onChange: (isDarkMode) {/* Noop*/},
      );

  Widget buildUser() => Center(
        child: Text(
          'Profil',
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          buildUser(),
          const SizedBox(
            height: 32,
          ),
          buildDarkMode(),
        ],
      );
}
