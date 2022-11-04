import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold.dart';
import 'package:flutter_application_mini_project/model/anime_service/anime_detail/anime_detail_object.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/widgets/top_detail_container/top_detail_container.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';

class DetailAnimeScreen extends StatelessWidget {
  const DetailAnimeScreen({super.key, required this.animeDetailObject});

  final AnimeDetailObject animeDetailObject;

  @override
  Widget build(BuildContext context) {

    List<String> listImg = [];
    (animeDetailObject.mainPicture != null)? listImg.add(animeDetailObject.mainPicture!) : null;
    (animeDetailObject.pictures != null)? listImg.addAll(animeDetailObject.pictures!) : null;

    return MyScaffold(

      colorPrimary: MyColor.primaryColor,
      scrollable: true,

      title: (isPortrait) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          animeDetailObject.title, 
          style: TextStyle(
            color: (isPortrait)? Colors.white : Colors.black, fontSize: 20,
          )
        ),
      ),
      

      child: (isPortrait) => Column(
        children: [
          TopDetailContainer(
            listImg: listImg,
            score: animeDetailObject.mean,
            rank: animeDetailObject.rank, 
            popularity: animeDetailObject.popularity,
            members: animeDetailObject.numListUsers,
          )
        ],
      )
    );
  }
}