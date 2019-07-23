import 'dart:convert' as convert;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class BoxScoreModel extends Equatable {
  final int away;
  final int home;
  final int awayRuns;
  final int awayHits;
  final int awayErrors;
  final int homeRuns;
  final int homeHits;
  final int homeErrors;
  final int inning;
  final String status;

  BoxScoreModel.empty()
      : away = 0,
        home = 0,
        awayRuns = 0,
        awayHits = 0,
        awayErrors = 0,
        homeRuns = 0,
        homeHits = 0,
        homeErrors = 0,
        inning = 0,
        status = "Not Started";

  factory BoxScoreModel.fromJSON(String json) {
    // parse request
    var obj;
    try {
      obj = convert.json.decode(json);
    } catch (e) {
      return BoxScoreModel.empty();
    }

    // populate box score model
    var scoring = obj['scoring'];
    var game = obj['game'];

    String status = game['playedStatus'];

    int awayTeam = game['awayTeam']['id'] ?? 0;
    int homeTeam = game['homeTeam']['id'] ?? 0;

    int awayRuns = scoring['awayScoreTotal'] ?? 0;
    int awayHits = scoring['awayHitsTotal'] ?? 0;
    int awayErrs = scoring['awayErrorsTotal'] ?? 0;

    int homeRuns = scoring['homeScoreTotal'] ?? 0;
    int homeHits = scoring['homeHitsTotal'] ?? 0;
    int homeErrs = scoring['homeErrorsTotal'] ?? 0;

    int inning = scoring['currentInning'] ?? scoring['innings'].length ?? 0;

    return BoxScoreModel(
      awayTeam,
      homeTeam,
      awayRuns,
      awayHits,
      awayErrs,
      homeRuns,
      homeHits,
      homeErrs,
      inning,
      status,
    );
  }

  BoxScoreModel(
    this.away,
    this.home,
    this.awayRuns,
    this.awayHits,
    this.awayErrors,
    this.homeRuns,
    this.homeHits,
    this.homeErrors,
    this.inning,
    this.status,
  );

  String toString() {
    String ar = awayRuns.toString().padLeft(2, '');
    String ah = awayHits.toString().padLeft(2, '');
    String ae = awayErrors.toString().padLeft(2, '');

    String hr = homeRuns.toString().padLeft(2, '');
    String hh = homeHits.toString().padLeft(2, '');
    String he = homeErrors.toString().padLeft(2, '');

    return '$away,$home,$ar,$ah,$ae,$hr,$hh,$he,$inning,$status';
  }

  bool isEmpty() {
    return away == 0;
  }
}
