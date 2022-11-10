import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/detail_anime_screen.dart';
import 'package:flutter_application_mini_project/screen/more_list/more_list_provider.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';
import 'package:provider/provider.dart';

class MoreListScreen extends StatefulWidget {
  const MoreListScreen({super.key, required this.rankingType});

  final String rankingType;

  @override
  State<MoreListScreen> createState() => _MoreListScreenState();
}

class _MoreListScreenState extends State<MoreListScreen> {

  @override
  void initState() {
    context.read<MoreListProvider>().setAllListNull(false);
    super.initState();
    context.read<MoreListProvider>().getListAnimeObject(widget.rankingType);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      colorPrimary: MyColor.primaryColor,
      colorSecondary: MyColor.primaryColor,
      scaffoldBgColor: MyColor.secondaryColor,
      scrollable: true,

      title: (isPortrait) => const Text('More List', style: TextStyle(color: Colors.white, fontSize: 20),),

      child: (isPortrait) => Consumer<MoreListProvider>(
        builder: (context, value, child) => GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 57/100,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: EdgeInsets.zero,
          children: [
            if(value.listAnimeObject != null)
              for(int i = 0; i < value.listAnimeObject!.listAnimeDetail.length; i++)
                Builder(
                  builder: (context) {
                    AnimeDetailObject animeDetailObject = value.listAnimeObject!.listAnimeDetail[i];

                    return Stack(
                      children: [
                        LayoutBuilder(
                          builder: (p0, p1constraint) => Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all()
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: p1constraint.maxWidth / 71 * 100,
                                      decoration: BoxDecoration(
                                        color: MyColor.primaryColor,
                                        image: (animeDetailObject.mainPicture != null)? DecorationImage(
                                          image: NetworkImage(animeDetailObject.mainPicture!)
                                        ) : null
                                      ),
                                    ),

                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
                                        ),
                                        child: Text('${(i + 1).toString()} #',),
                                      ),
                                    )
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(animeDetailObject.title, style: const TextStyle(fontSize: 17), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                )
                              ],
                            ),
                          ),
                        ),

                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async{ 
                                try{
                                  AnimeDetailObject temp = await value.getAnimeDetail(animeDetailObject.id);
                                  if(mounted) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailAnimeScreen(animeDetailObject: temp),));
                                  }
                                }
                                catch(e){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('An error occured'))
                                  );
                                }
                              },
                            ),
                          )
                        )
                      ],
                    );
                  }
                )
          ],
        ),
      )
    );
  }
}