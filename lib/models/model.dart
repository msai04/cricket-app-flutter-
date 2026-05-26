class MatchModel {
  final String id;
  final String name;
  final String status;
  final String matchType;
  final List<String> teams;
  final List<TeamInfo> teamInfo;
  final List<Score> score;
  final bool matchStarted;
  final bool matchended;
  final String venue;
  final  String datetimegmt;
  MatchModel({
    required this.id,
    required this.name,
    required this.status,
    required this.matchType,
    required this.teams,
    required this.teamInfo,
    required this.score,
    required this.matchStarted,
    required this.matchended,
    required this.venue,
    required this.datetimegmt
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      matchType: json['matchType'] ?? '',
      teams: List<String>.from(json['teams'] ?? []),
      teamInfo: (json['teamInfo'] as List? ?? [])
          .map((e) => TeamInfo.fromJson(e))
          .toList(),
      score: (json['score'] as List? ?? [])
          .map((e) => Score.fromJson(e))
          .toList(),
       matchStarted: json['matchStarted']?? true,
        matchended: json['matchEnded']?? true,
        venue :  json['venue'] ??'',
        datetimegmt: json['dateTimeGMT'] ?? ''
    );
  }
}
class TeamInfo {
  final String name;
  final String shortname;
  final String img;

  TeamInfo({
    required this.name,
    required this.shortname,
    required this.img,
  });

  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamInfo(
      name: json['name'] ?? '',
      shortname: json['shortname'] ?? '',
      img: json['img'] ?? '',
    );
  }
}
class Score {
  final int r;
  final int w;
  final double o;
  final String inning;

  Score({
    required this.r,
    required this.w,
    required this.o,
    required this.inning,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      r: json['r'] ?? 0,
      w: json['w'] ?? 0,
      o: (json['o'] ?? 0).toDouble(),
      inning: json['inning'] ?? '',
    );
  }
}