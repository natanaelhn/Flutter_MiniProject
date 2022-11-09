import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/services/anime_service.dart';
import 'package:recase/recase.dart';

class EditMyListAnimeProvider with ChangeNotifier{

  final List<String> listStatus = ['Watching', 'Completed','Plan To Watch', 'On Hold', 'Dropped'];

  final List<int> listScore = [10,9,8,7,6,5,4,3,2,1,0];
  final List<String> listScoreFormatted = [
    '10 (Masterpiece)',
    '9 (Great)',
    '8 (Very Good)',
    '7 (Good)',
    '6 (Fine)',
    '5 (Average)',
    '4 (Bad)',
    '3 (Very Bad)',
    '2 (Horrible)',
    '1 (Appaling)',
    '- (Not Yet Scored)'
  ];
  
  late AnimeService _animeService;

  late String _choosenStatus;
  late int _choosenScore;

  late bool _remindMe;

  EditMyListAnimeProvider(){
    setChoosenDefault();
    _animeService = AnimeService();
  }


  Future<void> updateMyListAnime({
    required int id,
    String? comments,
    bool? isRewatching,
    int? numTimesRewatched,
    int? numWatchedEpisodes,
    int? priority,
    int? rewatchValue,
    String? tags,
    
  }) async{
    await _animeService.updateMyListAnime(
      id: id,
      comments: comments,
      isRewatching: isRewatching,
      numTimesRewatched: numTimesRewatched,
      numWatchedEpisodes: numWatchedEpisodes,
      priority: priority,
      rewatchValue: rewatchValue,
      score: _choosenScore,
      status: ReCase(_choosenStatus).snakeCase,
      tags: tags,
    );
  }

  Future<void> deleteMyListAnime({required int id}) async{
    await _animeService.deleteMyListAnime(id: id);
  }


  void setChoosenStatus(String value){
    _choosenStatus = value;
    notifyListeners();
  }

  void setChoosenScore(int value){
    _choosenScore = value;
    notifyListeners();
  }

  void setRemindMe(bool value){
    _remindMe = value;
    notifyListeners();
  }

  String get choosenStatus{
    return _choosenStatus;
  }

  int get choosenScore{
    return _choosenScore;
  }

  bool get remindMe{
    return _remindMe;
  }

  void setAllChoosen({required AnimeDetailObject animeDetailObject, bool remindMe = false}){
    _choosenStatus = ReCase(animeDetailObject.myListStatus!.status!).titleCase;
    _choosenScore = animeDetailObject.myListStatus!.score!;
    _remindMe = remindMe;
  }

  void setChoosenDefault(){
    _choosenStatus = listStatus.first;
    _choosenScore = listScore.last;
    _remindMe = false;
  }

}