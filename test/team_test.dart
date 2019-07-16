import 'package:flutter_test/flutter_test.dart';
import 'package:odds/src/constants/teams.dart';

final List<String> teamNames = [
  'Nationals',
  'Bluejays',
  'Rangers',
  'Rays',
  'Cardinals',
  'Mariners',
  'Giants',
  'Padres',
  'Pirates',
  'Phillies',
  'Athletics',
  'Yankees',
  'Mets',
  'Twins',
  'Brewers',
  'Marlins',
  'Dodgers',
  'Angels',
  'Royals',
  'Tigers',
  'Rockies',
  'Indians',
  'Reds',
  'Whitesox',
  'Cubs',
  'Redsox',
  'Orioles',
  'Braves',
  'Diamondbacks',
  'Astros',
];

final List<String> locations = [
  'Atlanta',
  'Miami',
  'New York',
  'Philadelphia',
  'Nationals',
  'Chicago',
  'Cincinnati',
  'Milwaukee',
  'Pittsburgh',
  'St. Louis',
  'Arizona',
  'Colorado',
  'Los Angeles',
  'San Diego',
  'Giants',
  'Toronto',
  'Baltimore',
  'Tampa Bay',
  'Boston',
  'New York',
  'Cleveland',
  'Kansas City',
  'Detroit',
  'Minnesota',
  'Chicago',
  'Los Angeles',
  'Houston',
  'Oakland',
  'Seattle',
  'Texas',
];
void main() {
  testWidgets('Team Information Test', (WidgetTester tester) {
    TeamData teams = TeamData();
    List<Team> t;

    teamNames.forEach((name) {
      // names should match
      Team a = teams.getTeamByName(name);
      expect(a.name, name);
      // image name should match
      String lt = a.name.toLowerCase();
      expect('assets/$lt.png', a.image);
    });

    // should be 15 national league teams

    t = teams.getTeamsByLeague(leagueNational);
    expect(t.length, 15);

    // should be 5 teams in each division
    t = teams.getTeamsByLeagueAndDivision(leagueNational, divisionEast);
    expect(t.length, 5);

    t = teams.getTeamsByLeagueAndDivision(leagueNational, divisionCentral);
    expect(t.length, 5);

    t = teams.getTeamsByLeagueAndDivision(leagueNational, divisionWest);
    expect(t.length, 5);

    // should be 15 american league teams

    t = teams.getTeamsByLeague(leagueAmerican);
    expect(t.length, 15);

    // should be 5 teams in each division
    t = teams.getTeamsByLeagueAndDivision(leagueAmerican, divisionEast);
    expect(t.length, 5);

    t = teams.getTeamsByLeagueAndDivision(leagueAmerican, divisionCentral);
    expect(t.length, 5);

    t = teams.getTeamsByLeagueAndDivision(leagueAmerican, divisionWest);
    expect(t.length, 5);
  });
}
