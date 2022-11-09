
import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_image_loading_indicator/my_image_loading_indicator.dart';
import 'package:flutter_application_mini_project/common_widgets/my_loading/my_loading.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/detail_anime_screen.dart';
import 'package:flutter_application_mini_project/screen/edit_my_list_anime/edit_my_list_anime_screen.dart';
import 'package:flutter_application_mini_project/screen/my_list_anime/my_list_anime_provider.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class MyListAnimeScreen extends StatefulWidget {
  const MyListAnimeScreen({super.key});

  @override
  State<MyListAnimeScreen> createState() => _MyListAnimeScreenState();
}

class _MyListAnimeScreenState extends State<MyListAnimeScreen> {

  @override
  void initState() {

    context.read<MyListAnimeProvider>().setAllListNull();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      context.read<MyListAnimeProvider>().setIsLoading(true);
      await context.read<MyListAnimeProvider>().setMyListAnime();
      if(mounted){
        context.read<MyListAnimeProvider>().setIsLoading(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          colorPrimary: MyColor.primaryColor,
          colorSecondary: MyColor.primaryColor,
          scrollable: true,

          onRefresh: () async {
            return await context.read<MyListAnimeProvider>().setMyListAnime();
          },

          title: (isPortrait) => const Text('My List', style: TextStyle(color: Colors.white, fontSize: 20),),

          child: (isPortrait) => Consumer<MyListAnimeProvider>(
            builder: (context, value, child){
              if(value.listMyListAnime != null){
                return Container(

                  //Set minimal height so user can pull to refresh.
                  //User can't pull to refresh when the SingleChildScrollView is too short.
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 50 - MediaQuery.of(context).padding.top + 1),
                  width: double.infinity,
                  child: Column(
                    children: [
                      for(AnimeDetailObject i in value.listMyListAnime!.listAnimeDetail)
                        myListAnimeItem(i),
                    ],
                  ),
                );
              }
              else{
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Your list is empty', style: TextStyle(fontSize: 17),
                  ),
                );
              }
            },
          )
        ),

        Positioned.fill(child: Consumer<MyListAnimeProvider>(
          builder: (context, value, child) => MyLoading(
            isLoading: value.isLoading,
            color: MyColor.primaryColor,
          )
        )),
      ],
    );
  }

  Widget myListAnimeItem(AnimeDetailObject animeDetailObject){

    MyListAnimeProvider myListAnimeProvider = Provider.of<MyListAnimeProvider>(context, listen: false);
    final JustTheController justTheController = JustTheController();
    final String? urlImg = animeDetailObject.mainPicture;

    late final Color myStatusColor;

    switch(animeDetailObject.myListStatus!.status){
      case 'watching': myStatusColor = Colors.green;
        break;

      case 'completed': myStatusColor = Colors.blue;
        break;

      case 'on_hold': myStatusColor = Colors.orange;
        break;

      case 'dropped': myStatusColor = Colors.red;
        break;

      case 'plan_to_watch': myStatusColor = Colors.grey;
        break;
      
      default: myStatusColor = Colors.transparent;
        break;
      
    }

    return GestureDetector(
      onTap: () async{
        myListAnimeProvider.setIsLoading(true);
        try{
          AnimeDetailObject tempObject = await myListAnimeProvider.fetchGetUserAnimeList(id: animeDetailObject.id);
          if(mounted){
            await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailAnimeScreen(animeDetailObject: tempObject),));
          } 
          await myListAnimeProvider.setMyListAnime();
          myListAnimeProvider.setIsLoading(false);
          
        }
        catch(e){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An error occured'))
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 0),
        height: 242,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: myStatusColor, width: 3), bottom: BorderSide(color: MyColor.secondaryColor, width: 2))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
            const SizedBox(width: 4,),
        
            //Image
            Container(
              height: 180,
              width: 127.8,
              color: MyColor.primaryColor,
              child: (urlImg != null)? Image(
                image: NetworkImage(urlImg), loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress == null){
                    return child;
                  }
                  else{
                    double percent = loadingProgress.cumulativeBytesLoaded / loadingProgress.cumulativeBytesLoaded;
                    return MyImageLoadingIndicator(percent: percent);
                  }
                },
        
              ) : const Center(child: Image(image: AssetImage('assets/MAL logo noBg.png'), width: 70,))
            
            ),
        
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    //My List Anime Status
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 20, 
                        width: (2/5 * MediaQuery.of(context).size.width), 
                        decoration: BoxDecoration(
                          color: myStatusColor,
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10))
                        ),
                        child: Text(
                          ReCase(animeDetailObject.myListStatus!.status!).titleCase, 
                          style: const TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.w600, 
                            letterSpacing: 2, 
                            wordSpacing: 2
                          ),
                        ),
                      )
                    ),
    
                    const SizedBox(height: 10,),
    
                    //Anime Title
                    Text(
                      animeDetailObject.title, 
                      style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
        
                    const SizedBox(height: 6,),
            
                    Expanded(
                      child: Row(
                        children: [
        
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          
                                //Anime Status
                                Text(animeDetailObject.statusFormatted, style: const TextStyle(fontSize: 15),),
                                    
                                //Anime Broadcast
                                Text('Every ${animeDetailObject.broadcastDayTimeFormatted}', style: const TextStyle(fontSize: 15),),
                                    
                                Expanded(
                                  child: (animeDetailObject.myListStatus!.comments!.isNotEmpty) ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: JustTheTooltip(
                                      controller: justTheController,
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(animeDetailObject.myListStatus!.comments.toString()),
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          justTheController.showTooltip();
                                        },
                                        child: Text(
                                          '"${animeDetailObject.myListStatus!.comments.toString()}"', 
                                          style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                                          overflow: TextOverflow.ellipsis, 
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ) : const SizedBox(),
                                ),
                                
                              ],
                            ),
                          ),
        
                          const SizedBox(width: 8,),
        
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              
                              //Edit button
                              Tooltip(
                                message: 'Edit My List',
                                child: InkWell(
                                  onTap: () async{
                                    
                                    //return true when the listAnime is changed then refresh the column(ListAnime)
                                    bool? myListAnimeChanged = await Navigator.push(
                                      context, MaterialPageRoute(
                                        builder: (context) => EditMyListAnimeScreen(animeDetailObject: animeDetailObject,),
                                      )
                                    );
                                    
                                    if(myListAnimeChanged == true){
                                      myListAnimeProvider.setIsLoading(true);
                                      await myListAnimeProvider.setMyListAnime();
                                      myListAnimeProvider.setIsLoading(false);
                                    }
                                    
                                  },
                                  customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(color: MyColor.primaryColor)
                                    ),
                                    child: const Icon(Icons.edit_note, size: 20,),
                                  ),
                                ),
                              ),
        
                              const SizedBox(height: 8,),
        
                              //Delete button
                              Tooltip(
                                message: 'Remove from My List',
                                child: InkWell(
                                  onTap: () async{
                                    myListAnimeProvider.setIsLoading(true);
                                    try{
                                      await myListAnimeProvider.deleteMyListAnime(id: animeDetailObject.id);
                                      if(mounted){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Deleting list success'))
                                        );
                                      }
                                    }
                                    catch(e){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('An error occured when deleting list'))
                                      );
                                    }
                                    
                                    await myListAnimeProvider.setMyListAnime();
                                    myListAnimeProvider.setIsLoading(false);
                                    
                                    
                                  },
                                  customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(color: MyColor.primaryColor)
                                    ),
                                    child: const Icon(Icons.delete_outline_rounded, size: 20,),
                                  ),
                                ),
                              ),
        
                              const SizedBox(height: 8,)
                            ],
                          ),
        
                          const SizedBox(width: 8,)
                        ],
                      ),
                    ),
        
        
        
                    LayoutBuilder(
                      builder: (p0context, p1constraint) => Container(
                        height: 40,
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 4/5 * p1constraint.maxWidth,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30)),
                            color: MyColor.primaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                    
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8, left: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
        
                                      //My Score
                                      Row(
                                        children: [
                                          const Icon(Icons.star_rounded, color: Colors.white,),
                                          const SizedBox(width: 3,),
                                          Text(animeDetailObject.myListStatus!.scoreFormatted, style: const TextStyle(color: Colors.white, fontSize: 13),)
                                        ],
                                      ),
        
                                      //Anime episode watched
                                      Text(
                                        '${animeDetailObject.myListStatus!.numEpisodesWatched} / ${animeDetailObject.numEpisodeFormatted} ep watched', 
                                        style: const TextStyle(color: Colors.white, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                )
                              ),
        
                              //episode watched indicator
                              Builder(
                                builder: (context) {
                                  late final double percent;
                                  if (animeDetailObject.numEpisode == 0){
                                    if(animeDetailObject.myListStatus!.numEpisodesWatched == 0){
                                      percent = 0.00;
                                    }
                                    else{
                                      percent = 1.00;
                                    }
                                  }
                                  else{
                                    percent = (animeDetailObject.myListStatus!.numEpisodesWatched! / animeDetailObject.numEpisode!);
                                  }
    
                                  return Container(
                                    width: (4/5 * p1constraint.maxWidth) * 2 / 3,
                                    height: 5,
                                    color: Colors.white,
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      color: MyColor.greenColor,
                                      width: ((4/5 * p1constraint.maxWidth) * 2 / 3) * percent,
                                    ),
                                  );
                                }
                              )
                            ],
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}