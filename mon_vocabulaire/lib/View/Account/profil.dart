import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/app_bar.dart';
import 'package:mon_vocabulaire/Widgets/levels.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';
import '../../Widgets/Palette.dart';
import '../Settings/settings_page.dart';
import 'dart:io';

class Profil extends StatefulWidget {
  final User user;
  const Profil({super.key, required this.user});
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String image = 'assets/images/avatars/user.png';
  String name = '';
  Future<void> getUser() async {
    DatabaseHelper();
    User user = await DatabaseHelper().getUser(widget.user.id!);
    setState(() {
      image = user.image;
      name = user.name;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Moi",
        color: Palette.lightBlue,
        automaticallyImplyLeading: true,
        icon: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              SlideRight(
                page: SettingsPage(
                  user: widget.user,
                ),
              ),
            );
          },
          icon: const Icon(Icons.settings),
          tooltip: "Paramètres",
        ),
      ),
      body: image.isEmpty || name.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Palette.lightBlue,
              ),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: CircleAvatar(
                    radius: width / 5,
                    backgroundColor: Palette.lightBlue,
                    child: ClipOval(
                      child: image.startsWith("assets")
                          ? Image.asset(
                              image,
                              fit: BoxFit.cover,
                              width: width / 2.5,
                              height: width / 2.5,
                            )
                          : Image.file(
                              File(image),
                              fit: BoxFit.cover,
                              width: width / 2.5,
                              height: width / 2.5,
                            ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      name.replaceFirst(
                        name.characters.first,
                        name.characters.first.toUpperCase(),
                      ),
                      style: TextStyle(fontSize: width / 15),
                    ),
                  ),
                ),
                Levels(
                  user: widget.user,
                ),
              ],
            ),
    );
  }
}
