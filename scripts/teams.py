teams = [
    "Angels",
    "Athletics",
    "Bluejays",
    "Braves",
    "Brewers",
    "Cardinals",
    "Cubs",
    "Diamondbacks",
    "Dodgers",
    "Giants",
    "Indians",
    "Mariners",
    "Marlins",
    "Mets",
    "Nationals",
    "Orioles",
    "Padres",
    "Phillies",
    "Pirates",
    "Rangers",
    "Rays",
    "Reds",
    "Redsox",
    "Rockies",
    "RoyalsH",
    "Tigers",
    "Twins",
    "Whitesox",
    "Yankees",
]

for team in teams:
    print(
        f'Team {team}(\tname{team},\timage{team},\tleagueNational,\tdivisionEast);')

print('teams = {')
for team in teams:
    print(f'team[name{team}] = {team};')
print('}')
