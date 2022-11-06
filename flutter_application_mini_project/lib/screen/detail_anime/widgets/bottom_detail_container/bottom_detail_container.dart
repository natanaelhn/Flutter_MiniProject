import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_image_loading_indicator/my_image_loading_indicator.dart';
import 'package:flutter_application_mini_project/model/anime_service/anime_detail/anime_detail_object.dart';
import 'package:flutter_application_mini_project/model/anime_service/anime_detail/support_object/related_anime_object.dart';
import 'package:flutter_application_mini_project/model/anime_service/anime_service.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/detail_anime_screen.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';

class BottomDetailContainer extends StatefulWidget {
  const BottomDetailContainer({super.key, required this.listRelatedAnimeObject});

  final List<RelatedAnimeObject> listRelatedAnimeObject;

  @override
  State<BottomDetailContainer> createState() => _BottomDetailContainerState();
}

class _BottomDetailContainerState extends State<BottomDetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white,
            MyColor.secondaryColor,
          ]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Related Anime', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 16),
                for(RelatedAnimeObject i in widget.listRelatedAnimeObject)
                  relatedListItem(
                    id:  i.object.id, 
                    url: i.object.mainPicture, 
                    title: i.object.title, 
                    relation: i.relationTypeFormatted
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget relatedListItem ({required int id, String? url, required String title, required String relation}){
    return Stack(
      children: [

        //The Container
        Container(
          padding: const EdgeInsets.only(right: 8),
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Image
              Container(
                width: 120,
                height: 169.01,
                color: MyColor.primaryColor,
                child: (url != null)? Image(
                  image: NetworkImage(url,), 
                  loadingBuilder: (context, child, loadingProgress) {
                    
                    if(loadingProgress == null){
                      return child;
                    }
                    else{
                      double percent = loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!;
                      return MyImageLoadingIndicator(percent: percent);
                    }

                  },
                ) : const Center(child: Image(image: AssetImage('assets/MAL logo noBg.png'), width: 75,)),
              ),
              const SizedBox(height: 5,),

              //Anime Title
              Text(title, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 3,),

              //Relation
              Text(relation, style: const TextStyle(fontSize: 13, color: Colors.black54),),

            ],
          ),
        ),

        //The InkWell and Material
        Positioned.fill(child: Material(color: Colors.transparent, child: InkWell(
          onTap: () async{
            
            AnimeService animeService = AnimeService();
              try{
                AnimeDetailObject animeDetailObject = await animeService.fetchGetAnimeDetail(id: id.toString());
                if(mounted){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => 
                    DetailAnimeScreen(animeDetailObject: animeDetailObject),)
                  );
                } 
              }
              catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error when fetching data'))
                );
              }
          },
        ),))
      ],
    );
  }
}