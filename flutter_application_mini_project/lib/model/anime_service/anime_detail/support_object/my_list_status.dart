class MyListStatus{

  MyListStatus({
    this.status,
    this.score,
    this.numEpisodesWatched,
    this.isRewatching,
    this.startDate,
    this.finishDate,
    this.priority,
    this.numTimesRewatched,
    this.rewatchValue,
    this.tags,
    this.comments,
    this.updatedAt
  });

  final String? status;
  final int? score;
  final int? numEpisodesWatched;
  final bool? isRewatching;
  final String? startDate;
  final String? finishDate;
  final int? priority;
  final int? numTimesRewatched;
  final int? rewatchValue;
  final List<String>? tags;
  final String? comments;
  final String? updatedAt;

  factory MyListStatus.fromJSON(Map<String, dynamic> json){

    return MyListStatus(
      status: (json.containsKey('status'))? json['status'] : null,
      score: (json.containsKey('score'))? json['score'] : null,
      numEpisodesWatched: (json.containsKey('num_episodes_watched'))? json['num_episodes_watched'] : null,
      isRewatching: (json.containsKey('is_rewatching'))? json['is_rewatching'] : null,
      startDate: (json.containsKey('start_date'))? json['start_date'] : null,
      finishDate: (json.containsKey('finish_date'))? json['finish_date'] : null,
      priority: (json.containsKey('priority'))? json['priority'] : null,
      numTimesRewatched: (json.containsKey('num_times_rewatched'))? json['num_times_rewatched'] : null,
      rewatchValue: (json.containsKey('rewatch_value'))? json['rewatch_value'] : null,
      tags: (json.containsKey('tags'))? json['tags'] : null,
      comments: (json.containsKey('comments'))? json['comments'] : null,
      updatedAt: (json.containsKey('updated_at'))? json['updated_at'] : null,
    );
  }
}