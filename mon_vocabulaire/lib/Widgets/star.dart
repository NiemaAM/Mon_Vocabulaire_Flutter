import 'package:flutter/material.dart';

import 'Palette.dart';

class Star extends StatelessWidget {
  final int? nbStar;
  final String typebubble;
  const Star({super.key, required this.nbStar, required this.typebubble});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if(typebubble == "subtheme"){
      if(nbStar == 1){
        return Stack(
            children: [
              Positioned(
                  bottom: width < 500 ? -width / 4 : -130,
                  right: width < 500 ? -width / 5 : -130,
                  top: 0,
                  left: 0,
                  child: Icon(
                    Icons.star_rounded,
                    color: Palette.white,
                    size: width < 500 ? width / 7.5 : 65,
                  )),
              Positioned(
              bottom: width < 500 ? -width / 4 : -150,
              right: width < 500 ? -width / 5 : -50,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.white,
                size: width < 500 ? width / 7.5 : 65,
              )),
                Positioned(
                  bottom: width < 500 ? -width / 4 : -130,
                  right: width < 500 ? -width / 5 : -130,
                  top: 0,
                  left: 0,
                  child: Icon(
                    Icons.star_rounded,
                    color: Palette.yellow,
                    size: width < 500 ? width / 9.5 : 50,
                  )),
            Positioned(
              bottom: width < 500 ? -width / 4 : -150,
              right: width < 500 ? -width / 5 : -50,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color:Palette.lightGrey,
                size: width < 500 ? width / 9.5 : 50,
              ))
            ],
          );
      }else if(nbStar == 2){
        return Stack(
            children: [
              Positioned(
                  bottom: width < 500 ? -width / 4 : -130,
                  right: width < 500 ? -width / 5 : -130,
                  top: 0,
                  left: 0,
                  child: Icon(
                    Icons.star_rounded,
                    color: Palette.white,
                    size: width < 500 ? width / 7.5 : 65,
                  )),
              Positioned(
              bottom: width < 500 ? -width / 4 : -150,
              right: width < 500 ? -width / 5 : -50,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.white,
                size: width < 500 ? width / 7.5 : 65,
              )),
                Positioned(
                  bottom: width < 500 ? -width / 4 : -130,
                  right: width < 500 ? -width / 5 : -130,
                  top: 0,
                  left: 0,
                  child: Icon(
                    Icons.star_rounded,
                    color: Palette.yellow,
                    size: width < 500 ? width / 9.5 : 50,
                  )),
            Positioned(
              bottom: width < 500 ? -width / 4 : -150,
              right: width < 500 ? -width / 5 : -50,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.yellow,
                size: width < 500 ? width / 9.5 : 50,
              ))
            ],
          );
      }else{
        return Stack(
            children: [
              Positioned(
                  bottom: width < 500 ? -width / 4 : -130,
                  right: width < 500 ? -width / 5 : -130,
                  top: 0,
                  left: 0,
                  child: Icon(
                    Icons.star_rounded,
                    color: Palette.white,
                    size: width < 500 ? width / 7.5 : 65,
                  )),
              Positioned(
              bottom: width < 500 ? -width / 4 : -150,
              right: width < 500 ? -width / 5 : -50,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.white,
                size: width < 500 ? width / 7.5 : 65,
              )),
                Positioned(
                  bottom: width < 500 ? -width / 4 : -130,
                  right: width < 500 ? -width / 5 : -130,
                  top: 0,
                  left: 0,
                  child: Icon(
                    Icons.star_rounded,
                    color: nbStar!=0 ? Palette.lightGrey : Palette.lightGrey,
                    size: width < 500 ? width / 9.5 : 50,
                  )),
            Positioned(
              bottom: width < 500 ? -width / 4 : -150,
              right: width < 500 ? -width / 5 : -50,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: nbStar!=0 ? Palette.lightGrey : Palette.lightGrey,
                size: width < 500 ? width / 9.5 : 50,
              ))
            ],
          );
      }
      
    }else{

        if(nbStar == 1){
          return Stack(
              children: [
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.yellow,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color:Palette.lightGrey ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                      Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.lightGrey ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.lightGrey ,
                      size: width < 500 ? width / 9.5 : 50,
                    ))
              ],
            );
        }else if(nbStar == 2){
         return Stack(
              children: [
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.yellow,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color:Palette.yellow ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                      Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.lightGrey ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.lightGrey ,
                      size: width < 500 ? width / 9.5 : 50,
                    ))
              ],
            );
        }else if(nbStar == 3){
            return Stack(
              children: [
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.yellow,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color:Palette.yellow ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                      Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.lightGrey ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.yellow ,
                      size: width < 500 ? width / 9.5 : 50,
                    ))
              ],
            );
        }else if(nbStar == 4){
 return Stack(
              children: [
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.yellow,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color:Palette.yellow ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                      Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.yellow ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.yellow ,
                      size: width < 500 ? width / 9.5 : 50,
                    ))
              ],
            );
        }else{
          return
             Stack(
              children: [
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    right: width < 500 ? -width / 5 : -130,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.lightGrey,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    right: width < 500 ? -width / 5 : -50,
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color:Palette.lightGrey ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                      Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                Positioned(
                    bottom: width < 500 ? -width / 4 : -130,
                    left: width < 500 ? -width / 5 : -130,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.lightGrey ,
                      size: width < 500 ? width / 9.5 : 50,
                    )),

                    Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.white,
                      size: width < 500 ? width / 7.5 : 65,
                    )),
                  Positioned(
                    bottom: width < 500 ? -width / 4 : -150,
                    left: width < 500 ? -width / 5 : -50,
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.star_rounded,
                      color: Palette.lightGrey ,
                      size: width < 500 ? width / 9.5 : 50,
                    ))
              ],
            );
        }
      
    }
    
  }
}
