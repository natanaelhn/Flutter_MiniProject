import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/services/anime_service.dart';
import 'package:flutter_application_mini_project/model/list_anime_object.dart';
import 'package:flutter_application_mini_project/utils/my_token.dart';

class MainProvider with ChangeNotifier{

  bool? _isUserAuthorized;

  void setIsUserAuthorized(){
    _isUserAuthorized = MyToken.accessToken != null;
    setAnimeService();
    notifyListeners();
  }
  bool? get isUserAuthorized => _isUserAuthorized;

  late AnimeService _animeService;

  void setAnimeService(){
    if(_isUserAuthorized != null){
      _animeService = AnimeService();
      notifyListeners();
    }
  }


  //Dummy list
  ListAnimeObject listDummy = ListAnimeObject(
    listAnimeDetail: [
    AnimeDetailObject(id: -1, title: 'Example Title'),
    AnimeDetailObject(id: -1, title: 'Example Title'),
    AnimeDetailObject(id: -1, title: 'Example Title'),
    AnimeDetailObject(id: -1, title: 'Example Title'),
    AnimeDetailObject(id: -1, title: 'Example Title'),
    AnimeDetailObject(id: -1, title: 'Example Title'),
    AnimeDetailObject(id: -1, title: 'Example Title'),
    AnimeDetailObject(id: -1, title: 'Example Title'),
    AnimeDetailObject(id: -1, title: 'Example Title'),
    AnimeDetailObject(id: -1, title: 'Example Title')
  ], 
    nextUrl: null
  );

  ListAnimeObject? listTopAiring;

  ListAnimeObject getListTopAiring(){
    if(listTopAiring == null){
      return listDummy;
    }
    else{
      return listTopAiring!;
    }
  }



  ListAnimeObject? listTopUpcoming;

  ListAnimeObject getListTopUpcoming(){
    if(listTopUpcoming == null){
      return listDummy;
    }
    else{
      return listTopUpcoming!;
    }
  }



  ListAnimeObject? listSuggestion;

  ListAnimeObject getListSuggestion(){
    if(listSuggestion == null){
      return listDummy;
    }
    else{
      return listSuggestion!;
    }
  }

  Future<ListAnimeObject> getSuggestionAnime({
    int? limit = 10,
    int? offset = 0,
    String? fields,
  }) async{

    ListAnimeObject list;

    list = await _animeService.fetchGetAnimeSuggestion(
      limit: limit,
      offset: offset,
      fields: fields,
    );

    return list;
  }



  Future<ListAnimeObject> getAnimeRanking({
    required String rankingType,
    int? limit = 10,
    int? offset = 0,
    String? fields,
  }) async{

    ListAnimeObject list;

    list = await _animeService.fetchGetAnimeRanking(
      rankingType: rankingType,
      limit: limit,
      offset: offset,
      fields: fields,
    );

    return list;
  }




  void setAllList() async{
    listTopAiring = await getAnimeRanking(
      rankingType: 'airing',
      limit: 10,
      offset: 0,
    );
    listTopUpcoming = await getAnimeRanking(
      rankingType: 'upcoming',
      limit: 10,
      offset: 0,
    );
    listSuggestion = await getSuggestionAnime(
      limit: 10,
      offset: 0,
    );
  
    notifyListeners();
  }

  void setAllListNull({bool doNotifyListeners = false}){
    listTopAiring = null;
    listTopUpcoming = null;
    listSuggestion = null;
    if(doNotifyListeners){
      notifyListeners();
    }
  }

}