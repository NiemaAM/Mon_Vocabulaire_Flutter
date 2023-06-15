// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';

import 'package:mon_vocabulaire/View/Account/create_account.dart';
import 'package:mon_vocabulaire/Widgets/account_bloc.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<User> users = []; // List to store retrieved users
  RealtimeDataController controller = RealtimeDataController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> fetchUsers() async {
    await controller.getAllUsers();
    List<User> allUsers = controller.users;
    setState(() {
      users = allUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    fetchUsers();
    return Scaffold(
      backgroundColor: Palette.lightBlue,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Image.asset(
                "assets/images/logo.png",
                height: 200,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height / 4),
            child: SizedBox(
              height: height / 2 + 35,
              width: width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return AccountBloc(user: users[index]);
                },
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text("Mon Vocabulaire",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Palette.white)),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Button(
          callback: () {
            Navigator.of(context).push(
              SlideButtom(page: const CreateAccount()),
            );
          },
          content: Row(
            children: const [
              Expanded(
                flex: 20,
                child: Center(
                    child: Text(
                  "AJOUTER",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
              Icon(
                Icons.add_rounded,
                color: Palette.white,
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              )
            ],
          ),
          width: 170,
          heigth: 60,
          color: Palette.pink,
        ),
      ),
    );
  }
}
