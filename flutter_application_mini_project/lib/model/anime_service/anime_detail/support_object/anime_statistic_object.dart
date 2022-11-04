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
      watching: json['watching'], 
      completed: json['completed'], 
      onHold: json['on_hold'], 
      dropped: json['dropped'], 
      planToWatch: json['plan_to_watch'],
    );
  }
}