import '../constants/teams.dart';

class TeamData {
// MAP OF TEAM[name] to Object
  static Map<String, Team> _teams = {
    nameAngels: teamAngels,
    nameAstros: teamAstros,
    nameAthletics: teamAthletics,
    nameBluejays: teamBluejays,
    nameBraves: teamBraves,
    nameBrewers: teamBrewers,
    nameCardinals: teamCardinals,
    nameCubs: teamCubs,
    nameDiamondbacks: teamDiamondbacks,
    nameDodgers: teamDodgers,
    nameGiants: teamGiants,
    nameIndians: teamIndians,
    nameMariners: teamMariners,
    nameMarlins: teamMarlins,
    nameMets: teamMets,
    nameNationals: teamNationals,
    nameOrioles: teamOrioles,
    namePadres: teamPadres,
    namePhillies: teamPhillies,
    namePirates: teamPirates,
    nameRangers: teamRangers,
    nameRays: teamRays,
    nameReds: teamReds,
    nameRedsox: teamRedsox,
    nameRockies: teamRockies,
    nameRoyals: teamRoyals,
    nameTigers: teamTigers,
    nameTwins: teamTwins,
    nameWhitesox: teamWhitesox,
    nameYankees: teamYankees,
  };

  TeamData();

  Team getTeamByName(String name) {
    return _teams[name];
  }

  List<Team> getTeamsByLeague(String league) {
    return _teams.values.where((v) {
      return (v.league == league);
    }).toList();
  }

  List<Team> getTeamsByLeagueAndDivision(String league, String division) {
    return _teams.values.where((v) {
      return (v.league == league) && (v.division == division);
    }).toList();
  }

  Team getTeamByLocation(String location) {
    return _teams.values.firstWhere((v) {
      return (v.location == location);
    });
  }

  Team getTeamById(int id) {
    return _teams.values.firstWhere(
      (v) {
        return (v.id == id);
      },
      orElse: () => null,
    );
  }
}
