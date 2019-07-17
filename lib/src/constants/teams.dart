// leagues
const String leagueNational = 'National';
const String leagueAmerican = 'American';
const String divisionEast = 'East';
const String divisionCentral = 'Central';
const String divisionWest = 'West';

class Team {
  final String image;
  final String icon;
  final String name;
  final String league;
  final String division;
  final String location;
  final int id;

  Team(this.name, this.icon, this.image, this.league, this.division,
      this.location, this.id);
}

// TEAM IMAGES
const String imageNationals = 'assets/nationals.png';
const String imageBluejays = 'assets/bluejays.png';
const String imageRangers = 'assets/rangers.png';
const String imageRays = 'assets/rays.png';
const String imageCardinals = 'assets/cardinals.png';
const String imageMariners = 'assets/mariners.png';
const String imageGiants = 'assets/giants.png';
const String imagePadres = 'assets/padres.png';
const String imagePirates = 'assets/pirates.png';
const String imagePhillies = 'assets/phillies.png';
const String imageAthletics = 'assets/athletics.png';
const String imageYankees = 'assets/yankees.png';
const String imageMets = 'assets/mets.png';
const String imageTwins = 'assets/twins.png';
const String imageBrewers = 'assets/brewers.png';
const String imageMarlins = 'assets/marlins.png';
const String imageDodgers = 'assets/dodgers.png';
const String imageAngels = 'assets/angels.png';
const String imageRoyals = 'assets/royals.png';
const String imageTigers = 'assets/tigers.png';
const String imageRockies = 'assets/rockies.png';
const String imageIndians = 'assets/indians.png';
const String imageReds = 'assets/reds.png';
const String imageWhitesox = 'assets/whitesox.png';
const String imageCubs = 'assets/cubs.png';
const String imageRedsox = 'assets/redsox.png';
const String imageOrioles = 'assets/orioles.png';
const String imageBraves = 'assets/braves.png';
const String imageDiamondbacks = 'assets/diamondbacks.png';
const String imageAstros = 'assets/astros.png';

// TEAM ICONS
const String iconNationals = 'assets/nationals-icon.jpg';
const String iconBluejays = 'assets/bluejays-icon.jpg';
const String iconRangers = 'assets/rangers-icon.jpg';
const String iconRays = 'assets/rays-icon.jpg';
const String iconCardinals = 'assets/cardinals-icon.jpg';
const String iconMariners = 'assets/mariners-icon.jpg';
const String iconGiants = 'assets/giants-icon.jpg';
const String iconPadres = 'assets/padres-icon.jpg';
const String iconPirates = 'assets/pirates-icon.jpg';
const String iconPhillies = 'assets/phillies-icon.jpg';
const String iconAthletics = 'assets/athletics-icon.jpg';
const String iconYankees = 'assets/yankees-icon.jpg';
const String iconMets = 'assets/mets-icon.jpg';
const String iconTwins = 'assets/twins-icon.jpg';
const String iconBrewers = 'assets/brewers-icon.jpg';
const String iconMarlins = 'assets/marlins-icon.jpg';
const String iconDodgers = 'assets/dodgers-icon.jpg';
const String iconAngels = 'assets/angels-icon.jpg';
const String iconRoyals = 'assets/royals-icon.jpg';
const String iconTigers = 'assets/tigers-icon.jpg';
const String iconRockies = 'assets/rockies-icon.jpg';
const String iconIndians = 'assets/indians-icon.jpg';
const String iconReds = 'assets/reds-icon.jpg';
const String iconWhitesox = 'assets/whitesox-icon.jpg';
const String iconCubs = 'assets/cubs-icon.jpg';
const String iconRedsox = 'assets/redsox-icon.jpg';
const String iconOrioles = 'assets/orioles-icon.jpg';
const String iconBraves = 'assets/braves-icon.jpg';
const String iconDiamondbacks = 'assets/diamondbacks-icon.jpg';
const String iconAstros = 'assets/astros-icon.jpg';

// TEAM NAMES
const String nameAngels = 'Angels';
const String nameAstros = 'Astros';
const String nameAthletics = 'Athletics';
const String nameBluejays = 'Blue Jays';
const String nameBraves = 'Braves';
const String nameBrewers = 'Brewers';
const String nameCardinals = 'Cardinals';
const String nameCubs = 'Cubs';
const String nameDiamondbacks = 'Diamondbacks';
const String nameDodgers = 'Dodgers';
const String nameGiants = 'Giants';
const String nameIndians = 'Indians';
const String nameMariners = 'Mariners';
const String nameMarlins = 'Marlins';
const String nameMets = 'Mets';
const String nameNationals = 'Nationals';
const String nameOrioles = 'Orioles';
const String namePadres = 'Padres';
const String namePhillies = 'Phillies';
const String namePirates = 'Pirates';
const String nameRangers = 'Rangers';
const String nameRays = 'Rays';
const String nameReds = 'Reds';
const String nameRedsox = 'Red Sox';
const String nameRockies = 'Rockies';
const String nameRoyals = 'Royals';
const String nameTigers = 'Tigers';
const String nameTwins = 'Twins';
const String nameWhitesox = 'White Sox';
const String nameYankees = 'Yankees';

// mysportsfeeds team ids
const int idDiamondbacks = 140;
const int idBraves = 130;
const int idOrioles = 111;
const int idRedsox = 113;
const int idCubs = 131;
const int idWhitesox = 119;
const int idReds = 135;
const int idIndians = 116;
const int idRockies = 138;
const int idTigers = 117;
const int idAstros = 122;
const int idRoyals = 118;
const int idAngels = 124;
const int idDodgers = 137;
const int idMarlins = 128;
const int idBrewers = 134;
const int idTwins = 120;
const int idMets = 127;
const int idYankees = 114;
const int idAthletics = 125;
const int idPhillies = 129;
const int idPirates = 132;
const int idPadres = 139;
const int idGiants = 136;
const int idMariners = 123;
const int idCardinals = 133;
const int idRays = 115;
const int idRangers = 121;
const int idBluejays = 112;
const int idNationals = 126;

// TEAM OBJECTS

// NATIONAL LEAGUE
Team teamBraves = Team(nameBraves, iconBraves, imageBraves, leagueNational,
    divisionEast, 'Atlanta', idBraves);
Team teamMarlins = Team(nameMarlins, iconMarlins, imageMarlins, leagueNational,
    divisionEast, 'Miami', idMarlins);
Team teamMets = Team(nameMets, iconMets, imageMets, leagueNational,
    divisionEast, 'New York', idMets);
Team teamPhillies = Team(namePhillies, iconPhillies, imagePhillies,
    leagueNational, divisionEast, 'Philadelphia', idPhillies);
Team teamNationals = Team(nameNationals, iconNationals, imageNationals,
    leagueNational, divisionEast, 'Washington', idNationals);

Team teamBrewers = Team(nameBrewers, iconBrewers, imageBrewers, leagueNational,
    divisionCentral, 'Milwaukee', idBrewers);
Team teamCardinals = Team(nameCardinals, iconCardinals, imageCardinals,
    leagueNational, divisionCentral, 'Cincinnati', idCardinals);
Team teamCubs = Team(nameCubs, iconCubs, imageCubs, leagueNational,
    divisionCentral, 'Chicago', idCubs);
Team teamPirates = Team(namePirates, iconPirates, imagePirates, leagueNational,
    divisionCentral, 'Pittsburgh', idPirates);
Team teamReds = Team(nameReds, iconReds, imageReds, leagueNational,
    divisionCentral, 'St. Louis', idReds);

Team teamRockies = Team(nameRockies, iconRockies, imageRockies, leagueNational,
    divisionWest, 'Arizona', idRockies);
Team teamDiamondbacks = Team(
    nameDiamondbacks,
    iconDiamondbacks,
    imageDiamondbacks,
    leagueNational,
    divisionWest,
    'Colorado',
    idDiamondbacks);
Team teamDodgers = Team(nameDodgers, iconDodgers, imageDodgers, leagueNational,
    divisionWest, 'Los Angeles', idDodgers);
Team teamGiants = Team(nameGiants, iconGiants, imageGiants, leagueNational,
    divisionWest, 'San Diego', idPadres);
Team teamPadres = Team(namePadres, iconPadres, imagePadres, leagueNational,
    divisionWest, 'Giants', idGiants);

// AMERICAN LEAGUE
Team teamBluejays = Team(nameBluejays, iconBluejays, imageBluejays,
    leagueAmerican, divisionEast, 'Toronto', idBluejays);
Team teamOrioles = Team(nameOrioles, iconOrioles, imageOrioles, leagueAmerican,
    divisionEast, 'Baltimore', idOrioles);
Team teamRays = Team(nameRays, iconRays, imageRays, leagueAmerican,
    divisionEast, 'Tampa Bay', idRays);
Team teamRedsox = Team(nameRedsox, iconRedsox, imageRedsox, leagueAmerican,
    divisionEast, 'Boston', idRedsox);
Team teamYankees = Team(nameYankees, iconYankees, imageYankees, leagueAmerican,
    divisionEast, 'New York', idYankees);

Team teamIndians = Team(nameIndians, iconIndians, imageIndians, leagueAmerican,
    divisionCentral, 'Cleveland', idIndians);
Team teamRoyals = Team(nameRoyals, iconRoyals, imageRoyals, leagueAmerican,
    divisionCentral, 'Kansas City', idRockies);
Team teamTigers = Team(nameTigers, iconTigers, imageTigers, leagueAmerican,
    divisionCentral, 'Detroit', idTigers);
Team teamTwins = Team(nameTwins, iconTwins, imageTwins, leagueAmerican,
    divisionCentral, 'Minnesota', idTwins);
Team teamWhitesox = Team(nameWhitesox, iconWhitesox, imageWhitesox,
    leagueAmerican, divisionCentral, 'Chicago', idWhitesox);

Team teamAngels = Team(nameAngels, iconAngels, imageAngels, leagueAmerican,
    divisionWest, 'Los Angeles', idAngels);
Team teamAstros = Team(nameAstros, iconAstros, imageAstros, leagueAmerican,
    divisionWest, 'Houston', idAstros);
Team teamAthletics = Team(nameAthletics, iconAthletics, imageAthletics,
    leagueAmerican, divisionWest, 'Oakland', idAthletics);
Team teamMariners = Team(nameMariners, iconMariners, imageMariners,
    leagueAmerican, divisionWest, 'Seattle', idMariners);
Team teamRangers = Team(nameRangers, iconRangers, imageRangers, leagueAmerican,
    divisionWest, 'Texas', idRangers);
