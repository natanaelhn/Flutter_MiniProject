import 'package:flutter_application_mini_project/model/anime_detail_object.dart';

class ListAnimeObject{

  ListAnimeObject({required this.listAnimeDetail, required this.nextUrl});

  final List<AnimeDetailObject> listAnimeDetail;
  final String? nextUrl;

  factory ListAnimeObject.fromJSON(Map<String, dynamic> json){

    String? getNextUrl(Map<String, dynamic> json){
      String? value;
      if(json.containsKey('next')){
        value = json['next'];
      }
      return value;
    }

    List<AnimeDetailObject> getAnimeDetailObject(List<Map<String, dynamic>> json){

      List<AnimeDetailObject> list = [];
      for(Map i in json){
        list.add(AnimeDetailObject.fromJSON(i['node']) );
        
      }

      return list;
    }

    return ListAnimeObject(
      listAnimeDetail: getAnimeDetailObject(json['data'].cast<Map<String, dynamic>>() ),
      nextUrl: (json.containsKey('paging'))? getNextUrl(json['paging']) : null,
    );
  }
}