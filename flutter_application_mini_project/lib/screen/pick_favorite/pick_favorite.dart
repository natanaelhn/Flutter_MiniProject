import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold.dart';
import 'package:flutter_application_mini_project/utils/user_data.dart';
import 'package:flutter_application_mini_project/screen/main/main_screen.dart';
import 'package:flutter_application_mini_project/screen/pick_favorite/pick_favorite_provider.dart';
import 'package:flutter_application_mini_project/screen/pick_favorite/widgets/picture_container.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickFavorite extends StatefulWidget {
  const PickFavorite({super.key, required this.backButton});

  final bool backButton;

  @override
  State<PickFavorite> createState() => _PickFavoriteState();
}

class _PickFavoriteState extends State<PickFavorite> {

  PictureContainer pictureContainer = PictureContainer();
  JustTheController tooltipController = JustTheController();
  Timer? timer;
  
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    PickFavoriteProvider pickFavoriteProvider = Provider.of<PickFavoriteProvider>(context, listen: false);

    return MyScaffold(

      backButton: widget.backButton,
      title: (isPortrait) => Text(
        'Pick your favorite category', 
        style: TextStyle(
          color: (isPortrait)? Colors.white : Colors.black, fontSize: 20
        )
      ),

      colorPrimary: MyColor.primaryColor,
      colorSecondary: MyColor.secondaryColor,
      scrollable: false,

      subTrailing: (isPortrait) => [
        JustTheTooltip(
          controller: tooltipController,
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Pick favorite category to showcase everything related to the category.\nThis shown only for once. You can change it later.'),
          ),
          child: IconButton(
            onPressed: (){
              tooltipController.showTooltip();
            }, 
            icon: const Icon(Icons.info), 
            color: Colors.white,
          )
        )
      ],

      child: (isPortrait) {
        return Consumer<PickFavoriteProvider>(
          builder: (context, value, child) => LayoutBuilder(
            builder: (p0context, p1constraint) {
              
              double defaultDividerValue = ((isPortrait) ? p1constraint.maxHeight : p1constraint.maxWidth )/ 2;
              double dividerValue = defaultDividerValue;
        
              if(!pickFavoriteProvider.isAnime){
                if(pickFavoriteProvider.isManga){
                  dividerValue = defaultDividerValue * 9/10;
                }
              }
              else{
                dividerValue = defaultDividerValue * 11/10;
              }

              int animeIndex = pickFavoriteProvider.animeIndex;
              int mangaIndex = pickFavoriteProvider.mangaIndex;

              timer?.cancel();
              timer = Timer(const Duration(milliseconds: 3000), () {
                if(!pickFavoriteProvider.isAnime){
                  if(pickFavoriteProvider.isManga){
                    pickFavoriteProvider.incrementMangaIndex();
                  }
                }
                else{
                  pickFavoriteProvider.incrementAnimeIndex();
                }
              },);
        
              Widget animeContainer = GestureDetector(
                onTap: () {
                  pickFavoriteProvider.setIsAnime(true);
                  timer?.cancel();
                },
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: (pickFavoriteProvider.isAnime)? 1.0 : 0.5,
                      duration: const Duration(milliseconds: 1000),
                      child: pictureContainer.animeContainer1(isPortrait, dividerValue, animeIndex),
                    ),

                    Positioned(
                      top: (isPortrait)? null: 0,
                      bottom: (isPortrait)? 0: null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: (isPortrait)? Alignment.bottomCenter : Alignment.topLeft,
                            end: (isPortrait)? Alignment.topCenter : Alignment.bottomRight,
                            colors: const [
                              Colors.black,
                              Colors.transparent
                            ]
                          )
                        ),
                        child: const Text(
                          'ANIME', 
                          style: TextStyle(
                            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    )
                  ],
                )
              );
               
              
        
              Widget mangaContainer = GestureDetector(
                onTap: () {
                  pickFavoriteProvider.setIsAnime(false);
                  timer?.cancel();
                },
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: (pickFavoriteProvider.isManga)? 1.0 : 0.5,
                      duration: const Duration(milliseconds: 700),
                      child: pictureContainer.mangaContainer1(isPortrait, dividerValue, mangaIndex),
                    ),

                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: (isPortrait)? Alignment.topCenter : Alignment.topRight,
                            end: (isPortrait)? Alignment.bottomCenter : Alignment.bottomLeft,
                            colors: const[
                              Colors.black,
                              Colors.transparent
                            ]
                          )
                        ),
                        child: const Text(
                          'MANGA', 
                          style: TextStyle(
                            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
        
        
              return Stack(
                children: [
                  
                  //A Full black container behind anime and manga picture to blackend when the pictures opacity reduced
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black,
                  ),
        
                  //Anime and Manga Picture
                  (isPortrait)? Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      animeContainer,
                      Expanded( 
                        child: mangaContainer
                      )
                    ],
                  ) : Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      animeContainer,
                      Expanded( 
                        child: mangaContainer
                      )
                    ],
                  ),
        
        
                  //Button to save category
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 700),
                    top: (isPortrait)? dividerValue - 50 : p1constraint.maxHeight / 2 - 50,
                    left: (isPortrait)? p1constraint.maxWidth / 2 - 50 : dividerValue - 50,
                    child: Material(
                      shape: const CircleBorder(),
                      color: (!pickFavoriteProvider.isAnime && !pickFavoriteProvider.isManga)?
                        const Color.fromARGB(255, 71, 71, 71): MyColor.primaryColor,
                      child: InkWell(
                        onTap: () async{

                          if(!pickFavoriteProvider.isAnime && !pickFavoriteProvider.isManga){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Choose category first'))
                            );
                          }
                          else{
                            String favValue = (pickFavoriteProvider.isAnime)? 'Anime' : 'Manga';

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString(UserData.favCategoryKey, favValue);
                            
                            if (mounted)
                            {
                              Navigator.pushAndRemoveUntil(
                                context, 
                                MaterialPageRoute(builder: (context) => const MainScreen(),), 
                                (route) => false,
                              );
                            }
                            
                          }

                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(child: Text(
                            'Pick', 
                            style: TextStyle(color: Colors.white, fontSize: 20),)
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
              
              
            }
          ),
        );
      },
    );
  }
}