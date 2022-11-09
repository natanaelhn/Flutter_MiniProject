import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/services/anime_service.dart';
import 'package:flutter_application_mini_project/model/list_anime_object.dart';

class MyListAnimeProvider with ChangeNotifier{

  late final AnimeService _animeService;

  MyListAnimeProvider(){
    _animeService = AnimeService();
  }

  ListAnimeObject? listMyListAnime;
  

  void setAllListNull({bool doNotifyListeners = false}){
    listMyListAnime = null;

    if(doNotifyListeners){
      notifyListeners();
    }
  }

  void setMyListAnime() async{
    listMyListAnime = await _animeService.fetchGetUserAnimeList(limit: 500, sort: 'list_score');
    notifyListeners();
  }

  void deleteMyListAnime({required int id}) async{
    await _animeService.deleteMyListAnime(id: id);
  }

}