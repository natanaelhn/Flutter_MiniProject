import 'package:flutter_application_mini_project/model/anime_service/anime_detail/support_object/anime_statistic_object.dart';
import 'package:flutter_application_mini_project/model/anime_service/anime_detail/support_object/my_list_status.dart';
import 'package:flutter_application_mini_project/model/anime_service/anime_detail/support_object/related_anime_object.dart';
import 'package:recase/recase.dart';

class AnimeDetailObject{

  AnimeDetailObject({
    required this.id, 
    required this.title,
    this.mainPicture,
    this.startDate,
    this.endDate,
    this.synopsis,
    this.mean,
    this.rank,
    this.popularity,
    this.numListUsers,
    this.numScoringUsers,
    this.nsfw,
    this.mediaType,
    this.status,
    this.genres,
    this.numEpisode,
    this.startSeasonYear,
    this.startSeasonSeason,
    this.broadcastDay,
    this.broadcastTime,
    this.source,
    this.averageEpisodeDurationSecond,
    this.rating,
    this.pictures,
    this.background,
    this.relatedAnime,
    this.recommendation,
    this.studios,
    this.statistics,
    this.myListStatus,

  });

  final int id;
  final String title;
  String? mainPicture;
  String? startDate;
  String? endDate;
  String? synopsis;
  double? mean;
  int? rank;
  int? popularity;
  int? numListUsers;
  int? numScoringUsers;
  String? nsfw;
  String? mediaType;
  String? status;
  List<String>? genres;
  int? numEpisode;
  int? startSeasonYear;
  String? startSeasonSeason;
  String? broadcastDay;
  String? broadcastTime;
  String? source;
  int? averageEpisodeDurationSecond;
  String? rating;
  List<String>? pictures;
  String? background;
  List<RelatedAnimeObject>? relatedAnime;
  List<AnimeDetailObject>? recommendation;
  List<String>? studios;
  AnimeStatisticObject? statistics;
  MyListStatus? myListStatus;



  String get mediaTypeFormatted{
    List<String> temp = ['Unknown', 'TV', 'OVA', 'Movie', 'Special', 'ONA', 'Music'];

    for(String i in temp){
      if(mediaType == i.toLowerCase()){
        return i;
      }
    }

    return '?';
  }  

  String get startSeasonSeasonFormatted{
    List<String> temp = ['Winter', 'Spring', 'Summer', 'Fall'];

    for(String i in temp){
      if(startSeasonSeason == i.toLowerCase()){
        return i;
      }
    }

    return '?';
  }

  String get statusFormatted{
    List<String> temp = ['Finished Airing', 'Currently Airing', 'Not yet Aired'];

    for(String i in temp){
      if(status == i.toLowerCase().replaceAll(RegExp(' '), '_')){
        return i;
      }
    }

    return '?';
  }

  String get averageEpisodeDurationMinute{
    if(averageEpisodeDurationSecond != null){
      return (averageEpisodeDurationSecond! / 60).round().toString();
    }
    return '?';
  }

  String get broadcastDayFormatted{
    List<String> temp = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

    for(String i in temp){
      if(broadcastDay == i.toLowerCase()){
        return i;
      }
    }

    return '?';
  }

  String get ratingFormatted{
    List<String> temp = ['g', 'pg', 'pg_13', 'r', 'r+', 'rx'];
    List<String> temp2 = [
      'G - All Ages',
      'PG - Children',
      'PG-13 - Teens 13 or Older',
      'R-17+ - Violence & Profanity',
      'R+ - Profanity & Mild Nudity',
      'Rx - Hentai',
    ];

    for(int i = 0; i < temp.length; i++){
      if(rating == temp[i]){
        return temp2[i];
      }
    }

    return '?';
  }

  String get sourceFormatted{
    
    if(source != null){
      return ReCase(source!).titleCase;
    }

    return '?';
  }



  

  factory AnimeDetailObject.fromJSON(Map<String, dynamic> json){

    String getStringPicture(Map<String, dynamic> json){
      late String value;
      if(json.containsKey('large')){
        value = json['large'];
      }
      else if(json.containsKey('medium')){
        value = json['medium'];
      }

      return value;
    }

    List<String> getListGenres(List<Map<String, dynamic>> json){

      List<String> value = [];

      for(Map i in json){
        value.add(i['name']);
      }

      return value;
    }

    List<String> getListPictures(List<Map<String, dynamic>> json){

      List<String> value = [];

      for(Map<String, dynamic> i in json){
        value.add(getStringPicture(i));
      }

      return value;
    }

    List<String> getListStudios(List<Map<String, dynamic>> json){

      List<String> value = [];

      for(Map<String, dynamic> i in json){
        value.add(i['name']);
      }

      return value;
    }

    List<RelatedAnimeObject> getRelatedAnime(List<Map<String, dynamic>> json){

      List<RelatedAnimeObject> value = [];

      for(Map<String, dynamic> i in json){
        value.add( RelatedAnimeObject(
          object: AnimeDetailObject.fromJSON( i['node'] ), 
          relationTypeFormatted: i['relation_type_formatted'],
        ));
      }

      return value;
    }

    List<AnimeDetailObject> getRecommmendation(List<Map<String, dynamic>> json){

      List<AnimeDetailObject> value = [];

      for(Map<String, dynamic> i in json){
        value.add( AnimeDetailObject.fromJSON( i['node'] ) );
      }

      return value;
    }
 

    return AnimeDetailObject(
      id: json['id'],
      title: json['title'],
      mainPicture: (json.containsKey('main_picture'))? getStringPicture(json['main_picture']) : null ,
      startDate: (json.containsKey('start_date'))? json['start_date'] : null,
      endDate: (json.containsKey('end_date'))? json['end_date'] : null,
      synopsis: (json.containsKey('synopsis'))? json['synopsis'] : null,
      mean: (json.containsKey('mean'))? json['mean'] : null,
      rank: (json.containsKey('rank'))? json['rank'] : null,
      popularity: (json.containsKey('popularity'))? json['popularity'] : null,
      numListUsers: (json.containsKey('num_list_users'))? json['num_list_users'] : null,
      numScoringUsers: (json.containsKey('num_scoring_users'))? json['num_scoring_users'] : null,
      nsfw: (json.containsKey('nsfw'))? json['nsfw'] : null,
      mediaType: (json.containsKey('media_type'))? json['media_type'] : null,
      status: (json.containsKey('status'))? json['status'] : null,
      genres: (json.containsKey('genres'))? getListGenres(json['genres'].cast<Map<String, dynamic>>()) : null,
      numEpisode: (json.containsKey('num_episodes'))? json['num_episodes'] : null,
      startSeasonYear: (json.containsKey('start_season'))? json['start_season']['year'] : null,
      startSeasonSeason: (json.containsKey('start_season'))? json['start_season']['season'] : null,
      broadcastDay: (json.containsKey('broadcast'))? json['broadcast']['day_of_the_week'] : null,
      broadcastTime: (json.containsKey('broadcast'))? json['broadcast']['start_time'] : null,
      source: (json.containsKey('source'))? json['source'] : null,
      averageEpisodeDurationSecond: (json.containsKey('average_episode_duration'))? json['average_episode_duration'] : null,
      rating: (json.containsKey('rating'))? json['rating'] : null,
      pictures: (json.containsKey('pictures'))? getListPictures(json['pictures'].cast<Map<String, dynamic>>()) : null,
      background: (json.containsKey('background'))? json['background'] : null,
      relatedAnime: (json.containsKey('related_anime'))? getRelatedAnime(json['related_anime'].cast<Map<String, dynamic>>()) : null,
      recommendation: (json.containsKey('recommendations'))? getRecommmendation(json['recommendations'].cast<Map<String, dynamic>>()) : null,
      studios: (json.containsKey('studios'))? getListStudios(json['studios'].cast<Map<String, dynamic>>()) : null,
      statistics: (json.containsKey('statistics'))? AnimeStatisticObject.fromJSON(json['statistics']['status']) : null,
      myListStatus: (json.containsKey('my_list_status'))? MyListStatus.fromJSON(json['my_list_status']) : null,
    );
  }

}