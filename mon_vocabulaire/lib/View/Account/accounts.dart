// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
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

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Fetch users when the widget is initialized
  }

  Future<void> fetchUsers() async {
    // Fetch users from the database
    List<User> fetchedUsers = await DatabaseHelper().getAllUsers();
    setState(() {
      users = fetchedUsers;
      // Update the state with the fetched users
      // You can assign the fetched users to a class variable for further use
      // For example: this.users = users;
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Mon Vocabulaire",
                style: GoogleFonts.acme(
                  textStyle: const TextStyle(
                    color: Palette.white,
                    fontSize: 30,
                  ),
                ),
              ),
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
