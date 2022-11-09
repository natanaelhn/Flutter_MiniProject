import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/services/anime_service.dart';
import 'package:flutter_application_mini_project/model/list_anime_object.dart';
import 'package:flutter_application_mini_project/utils/my_loading_state.dart';

class MyListAnimeProvider with ChangeNotifier, MyLoadingState{

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

  Future<void> setMyListAnime() async{
    listMyListAnime = await _animeService.fetchGetUserAnimeList(limit: 500, sort: 'list_score');
    notifyListeners();
  }

  Future<void> deleteMyListAnime({required int id}) async{
    await _animeService.deleteMyListAnime(id: id);
  }

  Future<AnimeDetailObject> fetchGetUserAnimeList({required int id}) async{
    return await _animeService.fetchGetAnimeDetail(id: id.toString());
  }

  @override
  void setIsLoading(bool isLoading){
    super.setIsLoading(isLoading);
    notifyListeners();
  }
  

}