import 'package:flutter/material.dart';

class PictureContainer{

  Widget animeContainer1(bool isPortrait, double dividerValue, int index) {

    List<String> listImg = ['goku.jpg', 'naruto.jpg', 'one piece.jpg'];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      height: (isPortrait) ? dividerValue : null,
      width: (isPortrait) ? null : dividerValue,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/pickAnime/${listImg[index]}'), 
          fit: BoxFit.cover, 
        )
      ),
    );
  }

  Widget mangaContainer1(bool isPortrait, double dividerValue, int index) {

    List<String> listImg = ['dragon ball.jpg', 'naruto.jpg', 'one piece.jpg'];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/pickManga/${listImg[index]}'), 
          fit: BoxFit.cover,
        )
      ),
    );
  }

}