import 'package:dio/dio.dart';
import 'package:flutter_application_mini_project/model/anime_detail_object.dart';
import 'package:flutter_application_mini_project/model/list_anime_object.dart';
import 'package:flutter_application_mini_project/utils/my_token.dart';

class AnimeService{

  AnimeService();

  final Dio _dio = Dio();

  final String _url = 'https://api.myanimelist.net/v2/anime';





  Future<AnimeDetailObject> fetchGetAnimeDetail({required String id,}) async{

    final Response response = await _dio.get(
      '$_url/$id?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics',
    
      options: Options(
        headers: {
          'Authorization' : 'Bearer ${MyToken.accessToken}',
          'X-MAL-CLIENT-ID' : MyToken.clientId,
        }
      )
    );

    try{
      AnimeDetailObject animeDetailObject = AnimeDetailObject.fromJSON(response.data);
      return animeDetailObject;
    }
    catch(e){
      // print(e.toString());
    }
    return AnimeDetailObject.fromJSON(response.data);
  }




  Future<ListAnimeObject> fetchGetAnimeRanking({
    required String rankingType,
    int? limit,
    int? offset,
    String? fields,

  }) async{

    final Response response = await _dio.get(
      '$_url/ranking',

      queryParameters: {
        'ranking_type' : rankingType,
        'limit' : limit,
        'offset' : offset,
        'fields' : fields,
      },

      options: Options(
        headers: {
          'Authorization' : 'Bearer ${MyToken.accessToken}',
          'X-MAL-CLIENT-ID' : MyToken.clientId,
        }
      )
    );
    return ListAnimeObject.fromJSON(response.data);
  }





  Future<ListAnimeObject> fetchGetAnimeSuggestion({
    int? limit,
    int? offset,
    String? fields,
  }) async{

    final Response response = await _dio.get(
      '$_url/suggestions',

      queryParameters: {
        'limit' : limit,
        'offset' : offset,
        'fields' : fields,
      },

      options: Options(
        headers: {
          'Authorization' : 'Bearer ${MyToken.accessToken}',
        }
      )
    );

    return ListAnimeObject.fromJSON(response.data);
  }



  Future<ListAnimeObject> fetchGetUserAnimeList({
    String? status,
    String? sort,
    int? limit,
    int? offset,
  }) async{

    final Response response = await _dio.get(
      'https://api.myanimelist.net/v2/users/@me/animelist',

      queryParameters: {
        'status' : status,
        'sort' : sort,
        'limit' : limit,
        'offset' : offset,
        'fields' : 'num_episodes, broadcast, status, my_list_status{tags, comments}',
      },

      options: Options(
        headers: {
          'Authorization' : 'Bearer ${MyToken.accessToken}',
        }
      )
    );

    return ListAnimeObject.fromJSON(response.data);

  }


  Future<void> updateMyListAnime({
    required int id,
    String? status,
    bool? isRewatching,
    int? score,
    int? numWatchedEpisodes,
    int? priority,
    int? numTimesRewatched,
    int? rewatchValue,
    String? tags,
    String? comments,
  }) async{

    List<dynamic> bodyValue = [status, isRewatching, score, numWatchedEpisodes, priority, numTimesRewatched, rewatchValue, tags, comments];
    List<String> body = ['status', 'is_rewatching', 'score', 'num_watched_episodes', 'priority', 'num_times_rewatched', 'rewatch_value', 'tags', 'comments'];

    Map<String, dynamic> map = {};

    for(int i = 0; i < bodyValue.length; i++){
      if(bodyValue[i] != null){
        map[body[i]] = bodyValue[i]; 
      }
    }


    await _dio.put(
      '$_url/$id/my_list_status',

      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'Authorization' : 'Bearer ${MyToken.accessToken}',
        }
      ),
      data: map
    );
  }

  Future<void> deleteMyListAnime({required int id}) async{
    await _dio.delete(
      '$_url/$id/my_list_status',

      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'Authorization' : 'Bearer ${MyToken.accessToken}',
        }
      ),
    );
  }
}