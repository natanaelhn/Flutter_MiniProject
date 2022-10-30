import 'package:flutter/material.dart';

class PickFavoriteProvider with ChangeNotifier{
  
  bool _isAnime = false;
  bool get isAnime{
    return _isAnime;
  }

  bool _isManga = false;
  bool get isManga{
    return _isManga;
  }

  void setIsAnime(bool isAnime){
    _isAnime = isAnime;
    _isManga = !isAnime;
    notifyListeners();
  }

  int _animeIndex = 0;
  int get animeIndex{
    return _animeIndex;
  }

  void incrementAnimeIndex(){
    _animeIndex += 1;
    if(_animeIndex >= 3){
      _animeIndex = 0;
    }
    notifyListeners();
  }


  int _mangaIndex = 0;
  int get mangaIndex{
    return _mangaIndex;
  }

  void incrementMangaIndex(){
    _mangaIndex += 1;
    if(_mangaIndex >= 3){
      _mangaIndex = 0;
    }
    notifyListeners();
  }


}