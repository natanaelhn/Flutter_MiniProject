import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/screen/edit_my_list_anime/edit_my_list_anime_provider.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';
import 'package:flutter_application_mini_project/utils/my_notification.dart';
import 'package:provider/provider.dart';

class EditMyListAnimeScreen extends StatefulWidget {
  const EditMyListAnimeScreen({super.key, required this.animeDetailObject});

  final AnimeDetailObject animeDetailObject;

  @override
  State<EditMyListAnimeScreen> createState() => _EditMyListAnimeScreenState();
}

class _EditMyListAnimeScreenState extends State<EditMyListAnimeScreen> {

  late final bool isEdit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _episodeController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    isEdit = (widget.animeDetailObject.myListStatus == null)? false: true;
    _episodeController.text = (isEdit)? widget.animeDetailObject.myListStatus!.numEpisodesWatched.toString() : '0';
    
    final String? comments = (isEdit && widget.animeDetailObject.myListStatus!.comments != null)? widget.animeDetailObject.myListStatus!.comments : '';
    _commentController.text = comments!;
    
    if(isEdit){
      context.read<EditMyListAnimeProvider>().setAllChoosen(animeDetailObject: widget.animeDetailObject);
    }
    else{
      context.read<EditMyListAnimeProvider>().setChoosenDefault();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MyScaffold(
      colorPrimary: MyColor.primaryColor,
      colorSecondary: MyColor.primaryColor,

      title: (isPortrait) => const Text('Edit My List', style: TextStyle(color: Colors.white, fontSize: 20),),

      scrollable: true,

      child: (isPortrait) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          //Top Container contain image, title, etc
          Stack(
            children: [
              
              //The image in bottom layer
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: (widget.animeDetailObject.mainPicture == null) ? MyColor.primaryColor : Colors.white,
                  image: (widget.animeDetailObject.mainPicture == null) ? null
                    : DecorationImage(image: NetworkImage(widget.animeDetailObject.mainPicture!), fit: BoxFit.cover, opacity: 0.5)
                ),
              ),

              //The container contain title and etc in top layer
              Container(
                height: 160,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(0, 255, 255, 255),
                      Color.fromARGB(169, 255, 255, 255),
                      Colors.white
                    ]
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Title, status, broadcast
                    Text(
                      widget.animeDetailObject.title, 
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8,),
                    Text(widget.animeDetailObject.statusFormatted, style: const TextStyle(fontSize: 15)),
                    Text(widget.animeDetailObject.broadcastDayTimeFormatted, style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 8,),
                    const Divider(color: Colors.black, thickness: 1, height: 0),

                  ]
                ),
              ),
            ],
          ),


          //The Form
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 10,),

                  //Status
                  const Text('Status', style: TextStyle(fontSize: 17,)),

                  const SizedBox(height: 16,),

                  //Status DropdownButton
                  Center(
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: Consumer<EditMyListAnimeProvider>(
                        builder: (context, providerValue, child) => DropdownButton<String>(
                          isExpanded: true,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          value: providerValue.choosenStatus,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          style: const TextStyle(color: Colors.black, fontSize: 17),
                          underline: const SizedBox(),
                          selectedItemBuilder: (context) => providerValue.listStatus.map<Widget>((String value) {
                            return Center(child: Text(value),);
                          }).toList(),
                          onChanged: (value) {
                            providerValue.setChoosenStatus(value!);
                          },
                          items: providerValue.listStatus.map<DropdownMenuItem<String>>((String value){
                            return  DropdownMenuItem(
                              value: value,
                              child: Text(value)
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32,),

                  //Episode Watched
                  const Text('Episode Watched', style: TextStyle(fontSize: 17),),

                  const SizedBox(height: 16,),

                  //Episode TextFormField
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(width: 140,
                        child: TextFormField(
                          controller: _episodeController,
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 17),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Please give an input';
                            }
                            else {
                              int? number = int.tryParse(value);
                              if(number == null){
                                return 'Please input number only';
                              }
                              else{
                                return null;
                              }
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            counterText: '',
                          ),
                        ),
                      ),

                      const SizedBox(width: 10,),

                      Text(
                        '/ ${widget.animeDetailObject.numEpisodeFormatted} episode', 
                        style: const TextStyle(fontSize: 17),
                      )
                    ],
                  ),

                  const SizedBox(height: 32,),

                  //My Score
                  const Text('My Score', style: TextStyle(fontSize: 17,)),

                  const SizedBox(height: 16,),
                  
                  //My Score DropdownButton
                  Center(
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: Consumer<EditMyListAnimeProvider>(
                        builder: (context, providerValue, child) => DropdownButton<int>(
                          isExpanded: true,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          value: providerValue.choosenScore,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          style: const TextStyle(color: Colors.black, fontSize: 17),
                          underline: const SizedBox(),
                          selectedItemBuilder: (context) => providerValue.listScoreFormatted.map<Widget>((String value) {
                            return Center(child: Text(value),);
                          }).toList(),
                          onChanged: (value) {
                            providerValue.setChoosenScore(value!);
                          },
                          items: providerValue.listScore.map<DropdownMenuItem<int>>((int value){
                            return  DropdownMenuItem(
                              value: value,
                              child: Text(providerValue.listScoreFormatted[providerValue.listScore.indexOf(value)])
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32,),

                  //Checkbox for weekly reminding
                  Row(
                    children: [
                      Consumer<EditMyListAnimeProvider>(
                        builder: (context, providerValue, child) => Checkbox(
                          value: providerValue.remindMe, 
                          onChanged: (value) {

                            providerValue.setRemindMe(value!);
                          },
                        )
                      ),

                      const Text('Remind me every week', style: TextStyle(fontSize: 17),)
                    ],
                  ),

                  const SizedBox(height: 32,),

                  //Comment TextFormField
                  TextFormField(
                    controller: _commentController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Comments',
                      floatingLabelBehavior: FloatingLabelBehavior.always
                    ),
                  ),

                  const SizedBox(height: 32,),

                  //Delete and Done button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      //Delete Button
                      if(isEdit) Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: MyColor.redColor,
                              shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.delete, color: Colors.white, size: 35,),
                          ),

                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () async{
                                  try{
                                    await context.read<EditMyListAnimeProvider>().deleteMyListAnime(id: widget.animeDetailObject.id);
                                    if(mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Deleting list success'))
                                      );
                                      Navigator.pop(context, true);
                                    }
                                  }
                                  catch(e){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('An error occured when deleting list'))
                                    );
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),


                      //Done Button
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: MyColor.greenColor,
                              shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.done, color: Colors.white, size: 35,),
                          ),

                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () async{
                                  if(_formKey.currentState!.validate()){
                                    try{
                                      await context.read<EditMyListAnimeProvider>().updateMyListAnime(
                                        id: widget.animeDetailObject.id,
                                        numWatchedEpisodes: int.tryParse(_episodeController.text),
                                        comments: _commentController.text,
                                      );
                                      if(mounted){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Updating list is success'))
                                        );
                                        if(context.read<EditMyListAnimeProvider>().remindMe == true){
                                          AwesomeNotifications().isNotificationAllowed().then((isAllowed) async{
                                            if (!isAllowed) {
                                              AwesomeNotifications().requestPermissionToSendNotifications();
                                            }
                                            else {
                                              await AwesomeNotifications().createNotification(
                                                content: NotificationContent(
                                                  id: 10,
                                                  channelKey: MyNotification.channelKey,
                                                  title: '${widget.animeDetailObject.title} is live',
                                                  body: 'Hurry up grab your TV remote',
                                                  actionType: ActionType.Default,
                                                ),
                                                schedule: NotificationInterval(interval: 5)
                                              );
                                              
                                            }
                                          });
                                        }
                                        Navigator.pop(context, true);
                                      }
                                    }
                                    catch(e){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('An error occured when updating list'))
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )

                ],
              ),
            )
          )
        ],
      )
    );
  }
}