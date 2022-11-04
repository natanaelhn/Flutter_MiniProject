import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/model/anime_service/anime_detail/anime_detail_object.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';

class Top10ListContainer extends StatelessWidget {
  const Top10ListContainer({super.key, required this.listAnimeDetail, required this.title});

  final List<AnimeDetailObject> listAnimeDetail;
  final String title;

  final double height = 150;
  final double width = 106.5;

  //A Widget to show picture of list item
  Widget listItem(String? url, String name, bool isDummy){
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: 
      
      //The image and text of list item
      Stack(
        children: [

          //The visual
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height,
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // image: (url != null)? DecorationImage(image: NetworkImage(url), fit: BoxFit.cover, ) : null,
                  color: MyColor.primaryColor,
                ),
                child: (isDummy)? const SizedBox(
                  width: 69,
                  child: Image(image: AssetImage('assets/MAL logo noBg.png')) 
                ) : Image(
                  image: NetworkImage(url!), 
                  fit: BoxFit.cover, 
                  loadingBuilder: (context, child, loadingProgress) {

                    double? percent;
                    if(loadingProgress != null){
                      percent = loadingProgress.cumulativeBytesLoaded.toDouble() / loadingProgress.expectedTotalBytes!.toDouble();
                    }
                    
                    return (loadingProgress == null)? child 
                      : Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: percent,
                            color: Colors.white,
                          ),
                          Text((percent!*100).toInt().toString(), style: const TextStyle(color: Colors.white),)
                        ],
                      );
                  }
                ),
              ),
              const SizedBox(height: 5,),
              SizedBox(
                width: width,
                child: Text(
                  name, 
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              )
            ],
          ),


          Positioned.fill(child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){},
            ),
          ))
        ],
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color.fromARGB(255, 212, 222, 243),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            height: 220,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listAnimeDetail.length + 2,
              itemBuilder: (context, index){
                if(index == 0){
                  return const SizedBox(width: 16,);
                }

                //More List Widget
                else if(index == listAnimeDetail.length + 1){
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      color: MyColor.primaryColor,
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          alignment: Alignment.center,
                          height: height,
                          width: width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 69,
                                child: Image(image: AssetImage('assets/MAL logo noBg.png'))
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  SizedBox(width: 15,),
                                  Text('More list...', style: TextStyle(color: Colors.white),),
                                  Icon(Icons.chevron_right, color: Colors.white,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                bool isDummy = (listAnimeDetail[index-1].id == -1)? true : false;

                return listItem(listAnimeDetail[index-1].mainPicture, listAnimeDetail[index-1].title, isDummy);
              },
            ),
          )
        ],
      ),
    );
  }
}