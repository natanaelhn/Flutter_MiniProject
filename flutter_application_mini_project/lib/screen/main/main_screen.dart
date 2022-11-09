import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_column_divider/my_column_divider.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold.dart';
import 'package:flutter_application_mini_project/utils/my_token.dart';
import 'package:flutter_application_mini_project/screen/main/main_provider.dart';
import 'package:flutter_application_mini_project/screen/main/widgets/category_widget.dart';
import 'package:flutter_application_mini_project/screen/main/widgets/main_circle_button.dart';
import 'package:flutter_application_mini_project/screen/main/widgets/primary_container.dart';
import 'package:flutter_application_mini_project/screen/main/widgets/top_10_list_container.dart';
import 'package:flutter_application_mini_project/screen/my_list_anime/my_list_anime_screen.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {

    context.read<MainProvider>().setAllListNull();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MainProvider>().setIsUserAuthorized();
      context.read<MainProvider>().setAllList();
    });
  }

  @override
  Widget build(BuildContext context) {

    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

    // // Dummy List
    // List<AnimeDetailObject> list = [];

    // for(int i = 0; i < 10; i++){
    //   list.add(AnimeDetailObject(id: -1, title: 'Example Title'));
    // }

    return MyScaffold(
      backButton: false,
      scrollable: true,
      colorPrimary: MyColor.primaryColor,
      colorSecondary: MyColor.primaryColor,
      onRefresh: () async{
        mainProvider.setAllListNull(doNotifyListeners: true);
        mainProvider.setAllList();
      },

      title: (isPortrait) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Image(image: AssetImage('assets/MAL logo noBg.png'),),
            SizedBox(width: 10,),
            Text('TruDav UI' ,style: TextStyle(color: Colors.white, fontSize: 20),),
            Expanded(child: Align(alignment: Alignment.centerRight, child: CategoryWidget(isAnime: true,)))
          ],
        ),
      ),


      child: (isPortrait) => Column(
        mainAxisSize: MainAxisSize.max,
        children: [

          //PrimaryContainer
          Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryContainer(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('My List', style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 10,),
                  const Text(
                    'It seems that your list is empty. Let\'s fill it with the one you love',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('Add list', style: TextStyle(color: Colors.white),),
                      Icon(Icons.chevron_right, color: Colors.white,)
                    ]
                  ),
                ]
              ),
            )
          ),

          //Circle button container
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainCircleButton(title: 'My List', icon: Icons.list, onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyListAnimeScreen(),));
                },),
                MainCircleButton(title: 'Seasonal', icon: Icons.calendar_month, onTap: (){},),
                MainCircleButton(title: 'Forum', icon: Icons.forum, onTap: (){},),
              ],
            ),
          ),


          const MyColumnDivider(),
          
          //TOP AIRING
          Consumer<MainProvider>(
            builder: (context, value, child) => Top10ListContainer(
              listAnimeDetail: mainProvider.getListTopAiring().listAnimeDetail, 
              title: 'Top Airing',),
          ),


          const MyColumnDivider(),

          //TOP UPCOMING
          Consumer<MainProvider>(
            builder: (context, value, child) => Top10ListContainer(
              listAnimeDetail: mainProvider.getListTopUpcoming().listAnimeDetail, 
              title: 'Top Upcoming Anime',),
          ),


          const MyColumnDivider(),

          //ANIME FOR YOU
          (MyToken.accessToken != null)? Consumer<MainProvider>(
            builder: (context, value, child) => Top10ListContainer(
              listAnimeDetail: mainProvider.getListSuggestion().listAnimeDetail, 
              title: 'Anime For You',),
          ) : const SizedBox(),

          (MyToken.accessToken != null)? const MyColumnDivider(): const SizedBox(),


        ],
      ),
    );
  }
}