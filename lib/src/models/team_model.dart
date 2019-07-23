import '../constants/teams.dart';

class Team {
  final String image;
  final String icon;
  final String name;
  final String league;
  final String division;
  final String location;
  final int id;
  final String abbr;

  Team(this.name, this.icon, this.image, this.league, this.division,
      this.location, this.id, this.abbr);
}

// TEAM OBJECTS

// NATIONAL LEAGUE
Team teamBraves = Team(nameBraves, iconBraves, imageBraves, leagueNational,
    divisionEast, 'Atlanta', idBraves, abbrBraves);
Team teamMarlins = Team(nameMarlins, iconMarlins, imageMarlins, leagueNational,
    divisionEast, 'Miami', idMarlins, abbrMarlins);
Team teamMets = Team(nameMets, iconMets, imageMets, leagueNational,
    divisionEast, 'New York', idMets, abbrMets);
Team teamPhillies = Team(namePhillies, iconPhillies, imagePhillies,
    leagueNational, divisionEast, 'Philadelphia', idPhillies, abbrPhillies);
Team teamNationals = Team(nameNationals, iconNationals, imageNationals,
    leagueNational, divisionEast, 'Washington', idNationals, abbrNationals);

Team teamBrewers = Team(nameBrewers, iconBrewers, imageBrewers, leagueNational,
    divisionCentral, 'Milwaukee', idBrewers, abbrBrewers);
Team teamCardinals = Team(nameCardinals, iconCardinals, imageCardinals,
    leagueNational, divisionCentral, 'Cincinnati', idCardinals, abbrCardinals);
Team teamCubs = Team(nameCubs, iconCubs, imageCubs, leagueNational,
    divisionCentral, 'Chicago', idCubs, abbrCubs);
Team teamPirates = Team(namePirates, iconPirates, imagePirates, leagueNational,
    divisionCentral, 'Pittsburgh', idPirates, abbrPirates);
Team teamReds = Team(nameReds, iconReds, imageReds, leagueNational,
    divisionCentral, 'St. Louis', idReds, abbrReds);

Team teamRockies = Team(nameRockies, iconRockies, imageRockies, leagueNational,
    divisionWest, 'Arizona', idRockies, abbrRockies);
Team teamDiamondbacks = Team(
    nameDiamondbacks,
    iconDiamondbacks,
    imageDiamondbacks,
    leagueNational,
    divisionWest,
    'Colorado',
    idDiamondbacks,
    abbrDiamondbacks);
Team teamDodgers = Team(nameDodgers, iconDodgers, imageDodgers, leagueNational,
    divisionWest, 'Los Angeles', idDodgers, abbrDodgers);
Team teamGiants = Team(nameGiants, iconGiants, imageGiants, leagueNational,
    divisionWest, 'San Francisco', idGiants, abbrGiants);
Team teamPadres = Team(namePadres, iconPadres, imagePadres, leagueNational,
    divisionWest, 'Padres', idPadres, abbrPadres);

// AMERICAN LEAGUE
Team teamBluejays = Team(nameBluejays, iconBluejays, imageBluejays,
    leagueAmerican, divisionEast, 'Toronto', idBluejays, abbrBluejays);
Team teamOrioles = Team(nameOrioles, iconOrioles, imageOrioles, leagueAmerican,
    divisionEast, 'Baltimore', idOrioles, abbrOrioles);
Team teamRays = Team(nameRays, iconRays, imageRays, leagueAmerican,
    divisionEast, 'Tampa Bay', idRays, abbrRays);
Team teamRedsox = Team(nameRedsox, iconRedsox, imageRedsox, leagueAmerican,
    divisionEast, 'Boston', idRedsox, abbrRedsox);
Team teamYankees = Team(nameYankees, iconYankees, imageYankees, leagueAmerican,
    divisionEast, 'New York', idYankees, abbrYankees);

Team teamIndians = Team(nameIndians, iconIndians, imageIndians, leagueAmerican,
    divisionCentral, 'Cleveland', idIndians, abbrIndians);
Team teamRoyals = Team(nameRoyals, iconRoyals, imageRoyals, leagueAmerican,
    divisionCentral, 'Kansas City', idRoyals, abbrRoyals);
Team teamTigers = Team(nameTigers, iconTigers, imageTigers, leagueAmerican,
    divisionCentral, 'Detroit', idTigers, abbrTigers);
Team teamTwins = Team(nameTwins, iconTwins, imageTwins, leagueAmerican,
    divisionCentral, 'Minnesota', idTwins, abbrTwins);
Team teamWhitesox = Team(nameWhitesox, iconWhitesox, imageWhitesox,
    leagueAmerican, divisionCentral, 'Chicago', idWhitesox, abbrWhitesox);

Team teamAngels = Team(nameAngels, iconAngels, imageAngels, leagueAmerican,
    divisionWest, 'Los Angeles', idAngels, abbrAngels);
Team teamAstros = Team(nameAstros, iconAstros, imageAstros, leagueAmerican,
    divisionWest, 'Houston', idAstros, abbrAstros);
Team teamAthletics = Team(nameAthletics, iconAthletics, imageAthletics,
    leagueAmerican, divisionWest, 'Oakland', idAthletics, abbrAthletics);
Team teamMariners = Team(nameMariners, iconMariners, imageMariners,
    leagueAmerican, divisionWest, 'Seattle', idMariners, abbrMariners);
Team teamRangers = Team(nameRangers, iconRangers, imageRangers, leagueAmerican,
    divisionWest, 'Texas', idRangers, abbrRangers);

// MAP OF TEAM[name] to Object
Map<String, Team> _teams = {
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
  nameBluejays: teamBluejays,
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
