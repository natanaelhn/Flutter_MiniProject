import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/model/list_anime_object.dart';
import 'package:flutter_application_mini_project/services/anime_service.dart';

class MoreListProvider with ChangeNotifier{

  MoreListProvider(){
    _animeService = AnimeService();
  }

  late AnimeService _animeService;
  ListAnimeObject? listAnimeObject;

  Future<AnimeDetailObject> getAnimeDetail(int id) async{
    return _animeService.fetchGetAnimeDetail(id: id.toString());
  }

  Future<void> getListAnimeObject(String rankingType) async{

    if(rankingType == 'suggestion'){
      listAnimeObject = await _animeService.fetchGetAnimeSuggestion(
        limit: 100
      );
    }

    else{
      listAnimeObject = await _animeService.fetchGetAnimeRanking(
        rankingType: rankingType,
        limit: 200
      );
    }
    notifyListeners();
  }

  void setAllListNull(bool doNotifyListeners){
    listAnimeObject = null;
    if(doNotifyListeners){
      notifyListeners();
    }
  }
}