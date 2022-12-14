import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_column_divider/my_column_divider.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/widgets/bottom_detail_container/bottom_detail_container.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/widgets/mid_detail_container/mid_detail_container.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/widgets/top_detail_container/top_detail_container.dart';
import 'package:flutter_application_mini_project/screen/edit_my_list_anime/edit_my_list_anime_screen.dart';
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
      colorSecondary: MyColor.primaryColor,
      scrollable: true,

      subTrailing: (isPortrait) => [
        Tooltip(
          message: (animeDetailObject.myListStatus == null)? 'Add to My List' : 'Edit My List',
          child: TextButton(
            style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(50, 50))),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => 
                EditMyListAnimeScreen(
                  animeDetailObject: animeDetailObject,
                )
              ));
            }, 
            child: Icon(
              (animeDetailObject.myListStatus == null)? Icons.playlist_add : Icons.edit_note,
              color: Colors.white,
            )
          ),
        )
      ],

      title: (isPortrait) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          animeDetailObject.title, 
          style: const TextStyle(
            color:Colors.white, fontSize: 20,
          )
        ),
      ),
      

      child: (isPortrait) => Column(
        children: [

          //Container contain pictures, score, rank, popularity, members
          TopDetailContainer(
            listImg: listImg,
            score: animeDetailObject.mean,
            rank: animeDetailObject.rank, 
            popularity: animeDetailObject.popularity,
            members: animeDetailObject.numListUsers,
          ),

          MidDetailContainer(animeDetailObject: animeDetailObject,),

          const MyColumnDivider(),

          (animeDetailObject.relatedAnime != null && animeDetailObject.relatedAnime!.isNotEmpty)? 
            BottomDetailContainer(
              listRelatedAnimeObject: animeDetailObject.relatedAnime!,
            ) : const SizedBox(),
          
        ],
      )
    );
  }
}