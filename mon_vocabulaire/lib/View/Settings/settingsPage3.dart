import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Services/local_notification_service.dart';
import 'package:mon_vocabulaire/View/Account/accounts.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Model/user.dart';

class SettingsPage3 extends StatefulWidget {
  final User user;
  const SettingsPage3({super.key, required this.user});

  @override
  State<SettingsPage3> createState() => _SettingsPage3State();
}

class _SettingsPage3State extends State<SettingsPage3> {
  bool notfOn = true;
  bool darkOn = false;

  LocalNotificationService localNotificationService =
      LocalNotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.blue,
          title: const Text("Paramètres"),
          elevation: 1,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 15, right: 25, top: 15),
          itemExtent: 30,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Accounts(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Palette.blue,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Changer de compte"),
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              children: const [
                Icon(
                  Icons.person,
                  color: Palette.blue,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('Supprimer ce compte'),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(
                  Icons.notifications_active,
                  color: Palette.blue,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('Notifications'),
                ),
                const Expanded(child: SizedBox()),
                CupertinoSwitch(
                    // overrides the default green color of the track
                    activeColor: Palette.lightGreen,
                    // color of the round icon, which moves from right to left
                    thumbColor: notfOn ? Palette.darkGreen : Palette.blue,
                    // when the switch is off
                    trackColor: Palette.lightGrey,
                    // boolean variable value
                    value: notfOn,
                    // changes the state of the switch
                    onChanged: (value) {
                      if (notfOn) {
                        setState(() {
                          notfOn = false;
                        });
                        localNotificationService.showNotification(
                            "Tu nous as manqué",
                            "Il y a encore des mots à decouverire ");
                      } else {
                        setState(() {
                          notfOn = true;
                        });
                        localNotificationService.stopNotifications();
                      }
                    }),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(
                  Icons.dark_mode,
                  color: Palette.blue,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('Mode Sombre'),
                ),
                const Expanded(child: SizedBox()),
                CupertinoSwitch(
                    // overrides the default green color of the track
                    activeColor: Palette.lightGreen,
                    // color of the round icon, which moves from right to left
                    thumbColor: darkOn ? Palette.darkGreen : Palette.blue,
                    // when the switch is off
                    trackColor: Palette.lightGrey,
                    // boolean variable value
                    value: darkOn,
                    // changes the state of the switch
                    onChanged: (value) {
                      if (darkOn) {
                        setState(() {
                          darkOn = false;
                        });
                      } else {
                        setState(() {
                          darkOn = true;
                        });
                      }
                    }),
              ],
            ),
            const Divider(),
            Row(
              children: const [
                Icon(
                  Icons.bug_report,
                  color: Palette.blue,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('Signaler un problème'),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: const [
                Icon(
                  Icons.rate_review,
                  color: Palette.blue,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('Laisser un avis'),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: const [
                Icon(
                  Icons.info_outline,
                  color: Palette.blue,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('À propos  de cette application'),
                ),
              ],
            ),
          ],
        ));
  }
}
