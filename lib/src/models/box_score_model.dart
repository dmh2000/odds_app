import 'dart:convert' as convert;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class BoxScoreModel extends Equatable {
  final int _away;
  final int _home;
  final int _awayRuns;
  final int _awayHits;
  final int _awayErrors;
  final int _homeRuns;
  final int _homeHits;
  final int _homeErrors;
  final int _inning;
  BoxScoreModel.empty()
      : _away = 0,
        _home = 0,
        _awayRuns = 0,
        _awayHits = 0,
        _awayErrors = 0,
        _homeRuns = 0,
        _homeHits = 0,
        _homeErrors = 0,
        _inning = 0;

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

    int awayTeam = game['awayTeam']['id'];
    int homeTeam = game['homeTeam']['id'];

    int awayRuns = scoring['awayScoreTotal'];
    int awayHits = scoring['awayHitsTotal'];
    int awayErrs = scoring['awayErrorsTotal'];

    int homeRuns = scoring['homeScoreTotal'];
    int homeHits = scoring['homeHitsTotal'];
    int homeErrs = scoring['homeErrorsTotal'];

    int inning = scoring['currentInning'] ?? scoring['innings'].length;

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
    );
  }

  BoxScoreModel(
      this._away,
      this._home,
      this._awayRuns,
      this._awayHits,
      this._awayErrors,
      this._homeRuns,
      this._homeHits,
      this._homeErrors,
      this._inning);

  String toString() {
    String ar = _awayRuns.toString().padLeft(2, '');
    String ah = _awayHits.toString().padLeft(2, '');
    String ae = _awayErrors.toString().padLeft(2, '');

    String hr = _homeRuns.toString().padLeft(2, '');
    String hh = _homeHits.toString().padLeft(2, '');
    String he = _homeErrors.toString().padLeft(2, '');

    String inning = _inning.toString().padLeft(2, '');

    return '$_away,$_home,$ar,$ah,$ae,$hr,$hh,$he,$inning';
  }
}
