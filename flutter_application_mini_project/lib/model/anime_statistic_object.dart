class AnimeStatisticObject{

  AnimeStatisticObject({
    required this.watching,
    required this.completed,
    required this.onHold,
    required this.dropped,
    required this.planToWatch,
  }){
    total = watching + completed + onHold + dropped + planToWatch;
  }

  final int watching;
  final int completed;
  final int onHold;
  final int dropped;
  final int planToWatch;
  late final int total; 

  factory AnimeStatisticObject.fromJSON(Map<String, dynamic> json){
    return AnimeStatisticObject(
      watching: (json['watching'] != 0)? int.parse(json['watching']) : 0, 
      completed: (json['completed'] != 0)? int.parse(json['completed']) : 0, 
      onHold: (json['on_hold'] != 0)? int.parse(json['on_hold']) : 0, 
      dropped: (json['dropped'] != 0)? int.parse(json['dropped']) : 0, 
      planToWatch: (json['plan_to_watch'] != 0)? int.parse(json['plan_to_watch']) : 0,
    );
  }
}