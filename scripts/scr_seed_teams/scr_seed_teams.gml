/// scr_seed_teams()

// Create default team
var team = {};

team.team_name = "Generics";
team.city = "Metro City";
team.logo = 0;

// Use your full 39-color default palette
team.colours = [
    $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF,
    $FFFFFF, $00AEF0, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF,
    $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF,
    $3FA9F5, $FFFFFF, $00AEF0, $FFFFFF, $3FA9F5, $FFFFFF, $FFFFFF,
    $FFFFFF, $FFFFFF, $3FA9F5, $111111, $FFFFFF, $FFFFFF, $FFFFFF,
    $FFFFFF, $FFFFFF, $FFFFFF
];

// Default full roster: 53 players + 10 alternates
team.roster = [
{name: "David Longoria", pos: "QB", throw_pwr: 91, speed: 74, tackle: 27, agility: 72, burst: 62, truck: 22, durability: 75, num: 81},
{name: "Michael Johnson", pos: "QB", throw_pwr: 95, speed: 66, tackle: 19, agility: 65, burst: 69, truck: 14, durability: 84, num: 6},
{name: "David Carter", pos: "QB", throw_pwr: 89, speed: 66, tackle: 22, agility: 64, burst: 60, truck: 10, durability: 84, num: 56},
{name: "Robert Brown", pos: "RB", throw_pwr: 14, speed: 90, tackle: 32, agility: 86, burst: 85, truck: 54, durability: 85, num: 5},
{name: "John Davis", pos: "RB", throw_pwr: 19, speed: 83, tackle: 50, agility: 87, burst: 85, truck: 62, durability: 86, num: 53},
{name: "William Garcia", pos: "RB", throw_pwr: 16, speed: 91, tackle: 31, agility: 86, burst: 91, truck: 54, durability: 79, num: 99},
{name: "Joseph Martinez", pos: "FB", throw_pwr: 17, speed: 70, tackle: 52, agility: 62, burst: 68, truck: 91, durability: 90, num: 48},
{name: "Charles Robinson", pos: "WR", throw_pwr: 11, speed: 96, tackle: 24, agility: 86, burst: 92, truck: 40, durability: 78, num: 49},
{name: "Christopher Lewis", pos: "WR", throw_pwr: 12, speed: 85, tackle: 27, agility: 90, burst: 85, truck: 33, durability: 78, num: 21},
{name: "Daniel Lee", pos: "WR", throw_pwr: 10, speed: 98, tackle: 26, agility: 92, burst: 90, truck: 45, durability: 78, num: 17},
{name: "Matthew Walker", pos: "WR", throw_pwr: 19, speed: 85, tackle: 31, agility: 87, burst: 92, truck: 39, durability: 84, num: 69},
{name: "Anthony Hall", pos: "WR", throw_pwr: 13, speed: 95, tackle: 24, agility: 89, burst: 89, truck: 46, durability: 73, num: 35},
{name: "Joshua Allen", pos: "WR", throw_pwr: 20, speed: 97, tackle: 31, agility: 87, burst: 92, truck: 50, durability: 73, num: 83},
{name: "Nathan Longoria", pos: "TE", throw_pwr: 17, speed: 81, tackle: 65, agility: 82, burst: 66, truck: 66, durability: 86, num: 84},
{name: "Kevin Adams", pos: "TE", throw_pwr: 17, speed: 74, tackle: 62, agility: 72, burst: 77, truck: 82, durability: 75, num: 63},
{name: "Brian Baker", pos: "TE", throw_pwr: 16, speed: 83, tackle: 64, agility: 75, burst: 73, truck: 84, durability: 89, num: 76},
{name: "George Gonzalez", pos: "OL", throw_pwr: 12, speed: 51, tackle: 71, agility: 58, burst: 57, truck: 87, durability: 88, num: 71},
{name: "Edward Nelson", pos: "OL", throw_pwr: 16, speed: 50, tackle: 75, agility: 55, burst: 69, truck: 91, durability: 92, num: 96},
{name: "Timothy Mitchell", pos: "OL", throw_pwr: 14, speed: 56, tackle: 88, agility: 52, burst: 65, truck: 85, durability: 91, num: 14},
{name: "Jason Perez", pos: "OL", throw_pwr: 16, speed: 57, tackle: 82, agility: 63, burst: 59, truck: 86, durability: 92, num: 57},
{name: "Jeffrey Roberts", pos: "OL", throw_pwr: 17, speed: 52, tackle: 75, agility: 60, burst: 63, truck: 86, durability: 82, num: 92},
{name: "Ryan Turner", pos: "OL", throw_pwr: 18, speed: 57, tackle: 75, agility: 53, burst: 58, truck: 91, durability: 81, num: 93},
{name: "Jacob Phillips", pos: "OL", throw_pwr: 19, speed: 56, tackle: 85, agility: 65, burst: 61, truck: 90, durability: 94, num: 66},
{name: "Gary Campbell", pos: "OL", throw_pwr: 18, speed: 62, tackle: 77, agility: 65, burst: 61, truck: 91, durability: 92, num: 7},
{name: "Nicholas Parker", pos: "OL", throw_pwr: 12, speed: 52, tackle: 73, agility: 55, burst: 64, truck: 91, durability: 82, num: 94},
{name: "Eric Evans", pos: "DE", throw_pwr: 18, speed: 70, tackle: 80, agility: 72, burst: 79, truck: 76, durability: 82, num: 85},
{name: "Stephen Edwards", pos: "DE", throw_pwr: 17, speed: 79, tackle: 80, agility: 74, burst: 78, truck: 83, durability: 84, num: 24},
{name: "Jonathan Collins", pos: "DT", throw_pwr: 20, speed: 63, tackle: 93, agility: 60, burst: 67, truck: 89, durability: 90, num: 42},
{name: "Larry Stewart", pos: "DT", throw_pwr: 18, speed: 55, tackle: 91, agility: 57, burst: 73, truck: 87, durability: 82, num: 16},
{name: "Justin Sanchez", pos: "DL", throw_pwr: 11, speed: 60, tackle: 92, agility: 68, burst: 61, truck: 75, durability: 87, num: 50},
{name: "Scott Morris", pos: "DL", throw_pwr: 19, speed: 67, tackle: 87, agility: 62, burst: 62, truck: 83, durability: 89, num: 13},
{name: "Brandon Rogers", pos: "DL", throw_pwr: 14, speed: 75, tackle: 86, agility: 68, burst: 62, truck: 79, durability: 81, num: 91},
{name: "Frank Reed", pos: "DL", throw_pwr: 17, speed: 65, tackle: 90, agility: 58, burst: 72, truck: 86, durability: 95, num: 97},
{name: "Benjamin Cook", pos: "MLB", throw_pwr: 17, speed: 80, tackle: 94, agility: 70, burst: 70, truck: 71, durability: 79, num: 68},
{name: "Samuel Morgan", pos: "OLB", throw_pwr: 16, speed: 70, tackle: 90, agility: 75, burst: 89, truck: 69, durability: 78, num: 27},
{name: "Gregory Bell", pos: "OLB", throw_pwr: 10, speed: 75, tackle: 81, agility: 70, burst: 83, truck: 65, durability: 76, num: 47},
{name: "Patrick Murphy", pos: "LB", throw_pwr: 17, speed: 76, tackle: 91, agility: 82, burst: 85, truck: 62, durability: 83, num: 9},
{name: "Raymond Bailey", pos: "LB", throw_pwr: 14, speed: 75, tackle: 92, agility: 71, burst: 72, truck: 69, durability: 79, num: 26},
{name: "Jack Rivera", pos: "LB", throw_pwr: 20, speed: 72, tackle: 82, agility: 74, burst: 85, truck: 64, durability: 75, num: 3},
{name: "Dennis Cooper", pos: "LB", throw_pwr: 14, speed: 80, tackle: 91, agility: 84, burst: 77, truck: 74, durability: 79, num: 67},
{name: "Jerry Richardson", pos: "CB", throw_pwr: 10, speed: 85, tackle: 81, agility: 90, burst: 91, truck: 44, durability: 79, num: 82},
{name: "Tyler Cox", pos: "CB", throw_pwr: 10, speed: 85, tackle: 84, agility: 91, burst: 86, truck: 36, durability: 82, num: 62},
{name: "Aaron Howard", pos: "CB", throw_pwr: 14, speed: 85, tackle: 85, agility: 85, burst: 86, truck: 31, durability: 90, num: 28},
{name: "Henry Ward", pos: "FS", throw_pwr: 17, speed: 80, tackle: 89, agility: 88, burst: 85, truck: 61, durability: 90, num: 2},
{name: "Walter Torres", pos: "SS", throw_pwr: 20, speed: 83, tackle: 94, agility: 90, burst: 90, truck: 74, durability: 81, num: 41},
{name: "Peter Peterson", pos: "DB", throw_pwr: 10, speed: 84, tackle: 80, agility: 85, burst: 80, truck: 64, durability: 76, num: 22},
{name: "Douglas Gray", pos: "DB", throw_pwr: 17, speed: 80, tackle: 90, agility: 81, burst: 90, truck: 62, durability: 78, num: 90},
{name: "Zachary Ramirez", pos: "K", throw_pwr: 20, speed: 60, tackle: 16, agility: 62, burst: 57, truck: 15, durability: 80, num: 36},
{name: "Harold James", pos: "P", throw_pwr: 29, speed: 58, tackle: 15, agility: 73, burst: 56, truck: 18, durability: 83, num: 61},
{name: "Carl Watson", pos: "LS", throw_pwr: 16, speed: 57, tackle: 62, agility: 55, burst: 58, truck: 51, durability: 70, num: 33},
{name: "Russell Brooks", pos: "QB", throw_pwr: 92, speed: 66, tackle: 29, agility: 79, burst: 70, truck: 21, durability: 76, num: 40},
{name: "Philip Kelly", pos: "RB", throw_pwr: 11, speed: 81, tackle: 31, agility: 87, burst: 83, truck: 67, durability: 86, num: 4},
{name: "Nathan James", pos: "WR", throw_pwr: 11, speed: 92, tackle: 37, agility: 86, burst: 93, truck: 32, durability: 81, num: 38},
{name: "Ethan Moore", pos: "OL", throw_pwr: 16, speed: 56, tackle: 89, agility: 51, burst: 70, truck: 94, durability: 88, num: 45},
{name: "Adam Bennett", pos: "DL", throw_pwr: 10, speed: 60, tackle: 91, agility: 70, burst: 62, truck: 80, durability: 87, num: 10},
{name: "Shawn Turner", pos: "LB", throw_pwr: 16, speed: 77, tackle: 81, agility: 85, burst: 75, truck: 65, durability: 82, num: 89},
{name: "Cameron Scott", pos: "CB", throw_pwr: 15, speed: 85, tackle: 85, agility: 88, burst: 92, truck: 30, durability: 78, num: 72},
{name: "Logan Bell", pos: "S", throw_pwr: 18, speed: 89, tackle: 80, agility: 84, burst: 89, truck: 61, durability: 81, num: 98},
{name: "Connor Hughes", pos: "WR", throw_pwr: 10, speed: 87, tackle: 26, agility: 91, burst: 88, truck: 40, durability: 89, num: 75},
{name: "Travis Hill", pos: "TE", throw_pwr: 20, speed: 83, tackle: 65, agility: 83, burst: 70, truck: 80, durability: 75, num: 19},
];

// Store in global team map as template
if (!variable_global_exists("teams")) {
    global.teams = ds_map_create();
}
global.teams[? "TEMPLATE"] = team;
