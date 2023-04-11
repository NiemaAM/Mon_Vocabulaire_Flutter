import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/account.dart';
import 'package:mon_vocabulaire/View/games.dart';
import 'package:mon_vocabulaire/View/profil.dart';
import 'package:mon_vocabulaire/View/themes.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> page = [const Themes(), const Profil(), const Games()];
  int _selectedIndex = 0;
  bool _isHome = true;
  bool _isProfil = false;
  bool _isGames = false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          setState(() {
            _isHome = true;
            _isProfil = false;
            _isGames = false;
          });

          break;
        case 1:
          setState(() {
            _isHome = false;
            _isProfil = true;
            _isGames = false;
          });

          break;
        case 2:
          setState(() {
            _isHome = false;
            _isProfil = false;
            _isGames = true;
          });

          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.blue,
          title: const Text("Mon Parcours"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Accounts(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
              tooltip: "Changer de compte",
            )
          ],
        ),
        body: page[_selectedIndex],
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: SizedBox()),
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: _isHome ? Palette.pink : Colors.black45,
                ),
                onPressed: () {
                  _onItemTapped(0);
                },
              ),
              const Expanded(flex: 3, child: SizedBox()),
              IconButton(
                icon: Icon(Icons.gamepad,
                    color: _isGames ? Palette.pink : Colors.black45),
                onPressed: () {
                  _onItemTapped(2);
                },
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _isProfil
            ? null
            : FloatingActionButton(
                onPressed: () {
                  _onItemTapped(1);
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Palette.blue,
                  child: ClipOval(
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/3371/3371919.png",
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ));
  }
}