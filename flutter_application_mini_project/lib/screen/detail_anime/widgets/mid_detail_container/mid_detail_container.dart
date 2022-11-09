import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';

class MidDetailContainer extends StatelessWidget {
  const MidDetailContainer({super.key, required this.animeDetailObject});

  final AnimeDetailObject animeDetailObject;

  Widget genreContainer(String? title){
    return FittedBox(
      fit: BoxFit.none,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColor.primaryColor
        ),
        child: (title != null)? Text(
          title, 
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
        ) : const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),

          //Title
          LayoutBuilder(
            builder: (p0context, p1costraint) =>  Container(
              padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
              width: p1costraint.maxWidth * 8 / 10,
              decoration: BoxDecoration(
                color: MyColor.primaryColor,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
              ),
              child: Text(
                animeDetailObject.title, 
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
              )
            ),
          ),

          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


                //mediaType, Season&Year, status, numEpisode&averageMinute
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${animeDetailObject.mediaTypeFormatted}, ${animeDetailObject.startSeasonSeasonFormatted} ${animeDetailObject.startSeasonYear}',
                      style: const TextStyle(fontSize: 17),
                    ),
                    Text(animeDetailObject.statusFormatted, style: const TextStyle(fontSize: 17),),
                    Text(
                      '${animeDetailObject.numEpisode.toString()} ep, ${animeDetailObject.averageEpisodeDurationMinute} min',
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),

                const SizedBox(height: 10,),


                //Genres
                (animeDetailObject.genres != null)? Wrap(
                  alignment: WrapAlignment.spaceAround,
                  runSpacing: 5,
                  direction: Axis.horizontal,
                  children: [
                    for (String i in animeDetailObject.genres!) genreContainer(i)
                  ],
                ): const SizedBox(),

                const SizedBox(height: 10,),


                //Synopsis
                (animeDetailObject.synopsis != null)? LayoutBuilder(builder: (p0context, p1costraint) {

                  TextPainter tp = TextPainter(
                    maxLines: 7,
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    text: TextSpan(text: animeDetailObject.synopsis, style: const TextStyle(fontSize: 15)),
                  );

                  tp.layout(maxWidth: p1costraint.maxWidth - 20);
                  bool isExceedMaxLines = tp.didExceedMaxLines;


                  return Stack(
                    children: [

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              animeDetailObject.synopsis!, 
                              style: const TextStyle(fontSize: 15),
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          (isExceedMaxLines) ? const SizedBox(
                            height: 30, width: 20, child: Icon(Icons.chevron_right_rounded),
                          ) : const SizedBox()
                        ],
                      ),

                      (isExceedMaxLines)? Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              showModalBottomSheet(context: context, builder: (context) => Scrollbar(
                                thumbVisibility: true,
                                thickness: 8,
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(animeDetailObject.synopsis!)
                                  ),
                                ),
                              ),);

                            },
                          ),
                        ),
                      ) : const SizedBox(),
                    ],
                  );

                },) : const SizedBox(),

                const SizedBox(height: 5,),
                const Divider(color: Colors.black,),
                const SizedBox(height: 10,),

                Column(children: [

                  //First Row
                  Row(
                    children: [
                      
                      //Source
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Source', style: TextStyle(color: MyColor.primaryColor, fontSize: 17),),
                              Text(animeDetailObject.sourceFormatted, style: const TextStyle(fontSize: 17),)
                            ],
                          ),
                        ),
                      ),
                      
                      //Studio
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Studio', style: TextStyle(color: MyColor.primaryColor, fontSize: 17),),
                              (animeDetailObject.studios != null)? Wrap(
                                children: [
                                  for(int i = 0; i < animeDetailObject.studios!.length; i++)
                                    if(i == animeDetailObject.studios!.length - 1)
                                      Text(animeDetailObject.studios![i], style: const TextStyle(fontSize: 17),)
                                    else 
                                      Text('${animeDetailObject.studios![i]}, ', style: const TextStyle(fontSize: 17),)
                                ],
                              ) : const Text('?'),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),


                  const SizedBox(height: 16,),



                  //Second Row
                  Row(
                    children: [
                      
                      //Broadcast
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Broadcast', style: TextStyle(color: MyColor.primaryColor, fontSize: 17),),
                              Text(
                                '${animeDetailObject.broadcastDayFormatted}, ${animeDetailObject.broadcastTime} (JST)', 
                                style: const TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),

                      //Rating
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rating', style: TextStyle(color: MyColor.primaryColor, fontSize: 17),),
                              Text(
                                animeDetailObject.ratingFormatted,
                                style: const TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),


                  const SizedBox(height: 16,),



                  //Third Row
                  Row(
                    children: [
                      
                      //Aired
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Aired', style: TextStyle(color: MyColor.primaryColor, fontSize: 17),),
                              Text(
                                '${animeDetailObject.startDate} to ${animeDetailObject.endDate}', 
                                style: const TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),

                ],)
              ],
            ),
          )
        ],
      ),
    );
  }
}