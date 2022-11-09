import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_image_loading_indicator/my_image_loading_indicator.dart';
import 'package:flutter_application_mini_project/screen/detail_anime/widgets/top_detail_container/top_detail_container_provider.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TopDetailContainer extends StatefulWidget {
  const TopDetailContainer({
    super.key, 
    this.appbarSize = 50, 
    required this.listImg, 
    this.score, 
    this.rank,
    this.popularity,
    this.members,
  });

  final double appbarSize;
  final List<String> listImg;
  final double? score;
  final int? rank;
  final int? popularity;
  final int? members;

  @override
  State<TopDetailContainer> createState() => _TopDetailContainerState();
}

class _TopDetailContainerState extends State<TopDetailContainer> {

  PageController pageController = PageController();

  @override
  void initState() {

    context.read<TopDetailContainerProvider>().setDefault();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //Limit the count for image indicator to 5
    int imgCount = (widget.listImg.length >= 5)? 5 : widget.listImg.length;

    late double width;
    late double height;

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - widget.appbarSize;

    if(deviceWidth <= deviceHeight){
      width = deviceWidth * 5.5 / 10;
      height = width / 71 * 100;
    }
    else{
      height = deviceHeight;
      width = height / 100 * 71;
    }

    TopDetailContainerProvider topDetailContainerProvider = Provider.of(context, listen: false);

    return Stack(
      children: [

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: (widget.listImg.isEmpty) ? null : MyColor.secondaryColor,
              image: (widget.listImg.isEmpty) ? null
                : DecorationImage(image: NetworkImage(widget.listImg[0]), fit: BoxFit.cover, opacity: 0.35, filterQuality: FilterQuality.high)
            ),
          )
        ),

        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(0, 255, 255, 255),
                Colors.white
              ]
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  children: [

                    //ImageContainer
                    Container(
                      height: height,
                      width: width,
                      color: Colors.black26, 
                      child: (widget.listImg.isNotEmpty)? Builder(
                        builder: (context) {

                          return PageView(
                            controller: pageController,
                            onPageChanged: (value) {
                              topDetailContainerProvider.setIndex(value);
                            },
                            children: [

                              //1 to 5 Image
                              for(int i = 0; i < imgCount; i++)
                                Image(image: NetworkImage(widget.listImg[i]), loadingBuilder: (context, child, loadingProgress) {

                                  double? percent;
                                  (loadingProgress != null)? percent = loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null;

                                  return (loadingProgress == null)? child
                                    : MyImageLoadingIndicator(percent: percent!);
                                },),

                              // More Image view
                              if (widget.listImg.length > imgCount) Container(
                                color: Colors.black26, 
                                height: double.infinity, 
                                width: double.infinity,
                                
                                //More Button
                                child: Center(child: Stack(
                                  children: [
                                    Container(
                                      width: width * 5/10,
                                      height: width * 5/10,
                                      decoration: BoxDecoration(
                                        color: MyColor.primaryColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white)
                                      ),
                                      child: const Center(
                                        child: Text('More Picture', style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500
                                        ),)
                                      ),
                                    ),

                                    Positioned.fill(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          customBorder: const CircleBorder(),
                                          onTap: (){
                                            
                                            //Show all image
                                            showModalBottomSheet(
                                              context: context, 
                                              builder: (context) {
                                                return GridView.count(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 8,
                                                  mainAxisSpacing: 8,
                                                  childAspectRatio: 71/100,
                                                  children: [
                                                    for(String i in widget.listImg)
                                                      Container(
                                                        color: MyColor.primaryColor,
                                                        child: Image(
                                                          image: NetworkImage(i),
                                                          loadingBuilder: (context, child, loadingProgress) {
                        
                                                            if(loadingProgress == null){
                                                              return child;
                                                            }
                                                            else{
                                                              double percent = loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!;
                                                              return MyImageLoadingIndicator(percent: percent);
                                                            }

                                                          },
                                                        )
                                                      )
                                                  ],
                                                );
                                              },
                                            );

                                          },
                                        ),
                                      )
                                    )
                                  ],
                                )),
                              )
                            ],
                          );
                        }
                      )
                        : Center(
                          child: SizedBox(
                            width: width * 5.5 / 10,
                            child: const Image(image: AssetImage('assets/MAL logo noBg.png'),)
                          ),
                        )
                    ),

                    //Image Indicator
                    Consumer<TopDetailContainerProvider>(
                      builder: (context, value, child) => Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: width,
                        height: 20,
                        decoration: BoxDecoration(
                          color: MyColor.primaryColor,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            //1 to 6 dot
                            for(int i = 0; i < ((widget.listImg.length > imgCount)? imgCount + 1 : imgCount); i++)
                              Container(
                                height: (topDetailContainerProvider.index == i)? 10 : 5,
                                width: (topDetailContainerProvider.index == i)? 10 : 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: (topDetailContainerProvider.index == i)? Colors.white 
                                    : MyColor.secondaryColor,
                                ),
                                child: (topDetailContainerProvider.index == i)? FittedBox(
                                  fit: BoxFit.none,
                                  child: Container(
                                    height: 5, 
                                    width: 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: MyColor.primaryColor
                                    ),
                                  ),
                                ) : const SizedBox(),
                              )
                          ]
                        ),
                      ),
                    )
                  ],
                ),
              ),


              //Info on the right
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      //Score
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MyColor.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.white, size: 35,),
                            const SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Score', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                                ),),
                                Text((widget.score == null)? '?' : widget.score.toString(), style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),



                      //Rank
                      Container(
                        margin: const EdgeInsets.only(top: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Rank', style: TextStyle(
                              color: Colors.black,
                              fontSize: 17
                            ),),
                            Text((widget.rank == null)? '?' : '#${widget.rank.toString()}', style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),),
                          ],
                        ),
                      ),



                      //Popularity
                      Container(
                        margin: const EdgeInsets.only(top: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Popularity', style: TextStyle(
                              color: Colors.black,
                              fontSize: 17
                            ),),
                            Text((widget.popularity == null)? '?' : '#${widget.popularity.toString()}', style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),),
                          ],
                        ),
                      ),


                      //Members
                      Container(
                        margin: const EdgeInsets.only(top: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Members', style: TextStyle(
                              color: Colors.black,
                              fontSize: 17
                            ),),
                            Text((widget.members == null)? '?' : NumberFormat('#,##0').format(widget.members), style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ],
    );
  }
}