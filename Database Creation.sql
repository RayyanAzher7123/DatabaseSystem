-- Drop database if it exists to ensure a clean reset 
DROP database IF EXISTS Assignment2;
create database Assignment2;
use Assignment2;

-- Drop tables if they exist to ensure a clean reset 
DROP TABLE IF EXISTS Goals;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Teams;

-- Create the Teams table
CREATE TABLE Teams (
    TeamID INT PRIMARY KEY,
    TeamName VARCHAR(100) NOT NULL,
    FoundedYear INT,
    StadiumName VARCHAR(100),
    StadiumCapacity INT
    
);


-- Create the Players table
CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE CONSTRAINT Older_than_16 CHECK (DateOfBirth <= DATE '2005-12-31'), -- Players added should be born before 2006
    Nationality VARCHAR(50),
    Position VARCHAR(50),
    TeamID INT,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
    
);


-- Create the Matches table
CREATE TABLE Matches (
    MatchID INT PRIMARY KEY,
    HomeTeamID INT,
    AwayTeamID INT,
    MatchDate DATE,
    Result VARCHAR(100),
    FOREIGN KEY (HomeTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (AwayTeamID) REFERENCES Teams(TeamID),
    
    CONSTRAINT valid_result CHECK (Result IN ('Home Win', 'Draw', 'Away Win')) -- result value should be limited to these only
    );


-- Create the Goals table
CREATE TABLE Goals (
    GoalID INT PRIMARY KEY,
    MatchID INT,
    ScorerPlayerID INT,
    AssistPlayerID INT,
    MinuteScored INT CONSTRAINT Scored_before_90 CHECK (MinuteScored <=90), -- This constraint makes sure the goal scored is within 90 minutes of the game
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (ScorerPlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (AssistPlayerID) REFERENCES Players(PlayerID),
    
    CONSTRAINT scorer_notequal_assister CHECK (ScorerPlayerID <> AssistPlayerID) -- The constraint to check the player that scored cannot assist himself
    );
    
-- Clean or reset the table data if script was to re-run


    
    -- The Teams table has the Top 10 best teams in the world and their information
    INSERT INTO Teams 
    VALUES 
    (1,"Arsenal",1886,"Emirates Stadium",60704),
    (2,"Real Madrid",1902,"Santiago Bernabeu",81044),
    (3,"FC Barcelona",1899,"Camp Nou Stadium",99354),
    (4,"Manchester United",1878,"Old Trafford",74310),
    (5,"Chelsea",1905,"Stamford Bridge",40341),
    (6,"Bayern Munich",1900,"Allianz Arena",75024),
    (7,"Liverpool FC",1892,"Anfield",54074),
    (8,"Manchester City",1880,"Etihad Stadium",53400),
    (9,"Juventus FC",1897,"Allianz Stadium",41507),
    (10,"Inter Milan",1908,"San Siro Stadium",80018);
    
    -- Each Team has a Starting 11 of players which means there are 110 players inserted from 10 teams into the Players table
    INSERT INTO Players 
	VALUES
    (1, 'David', 'Raya', '1998-05-15', 'Spain', 'GK', 1),
    (2, 'Ben', 'White', '1997-10-08', 'England', 'RB', 1),
    (3, 'William', 'Saliba', '2001-03-24', 'France', 'RCB', 1),
    (4, 'Gabriel', 'Magalhaes', '1997-12-19', 'Brazil', 'LCB', 1),
    (5, 'Jurrien', 'Timber', '2001-06-17', 'Netherlands', 'LB', 1),
    (6, 'Declan', 'Rice', '1999-01-14', 'England', 'DM', 1),
    (7, 'Thomas', 'Partey', '1993-06-13', 'Ghana', 'RCM', 1),
    (8, 'Martin', 'Ødegaard', '1998-12-17', 'Norway', 'LCM', 1),
    (9, 'Bukayo', 'Saka', '2001-09-05', 'England', 'RW', 1),
    (10, 'Gabriel', 'Jesus', '1997-04-03', 'Brazil', 'ST', 1),
    (11, 'Gabriel', 'Martinelli', '2001-06-18', 'Brazil', 'LW', 1),
    
     (12, 'Thibaut', 'Courtois', '1992-05-11', 'Belgium', 'GK', 2),
	 (13, 'Dani', 'Carvajal', '1992-01-11', 'Spain', 'RB', 2),
	(14, 'Antonio', 'Rudiger', '1993-03-03', 'France', 'RCB', 2),
	(15, 'David', 'Alaba', '1992-06-24', 'Austria', 'LCB', 2),
	(16, 'Eduardo', 'Camavinga', '2002-11-10', 'France', 'LB', 2),
	(17, 'Aurélien', 'Tchouaméni', '2000-01-27', 'France', 'CDM', 2),
    (18, 'Toni', 'Kroos', '1990-01-04', 'Germany', 'RCM', 2),
    (19, 'Luka', 'Modric', '1985-09-09', 'Croatia', 'LCM', 2),
    (20, 'Rodrygo', 'Silva', '2001-01-09', 'Brazil', 'RW', 2),
    (21, 'Jude', 'Bellingham', '2003-06-29', 'England', 'ST', 2),
    (22, 'Vinicius', 'Junior', '2000-07-12', 'Brazil', 'LW', 2),
    
    (23, 'Ter', 'Stegen', '1992-04-30', 'Germany', 'GK', 3),
    (24, 'Jules', 'Kounde', '1998-11-12', 'France', 'RB', 3),
    (25, 'Ronald', 'Araujo', '1999-03-07', 'Uruguay', 'RCB', 3),
    (26, 'Andreas', 'Christensen', '1996-04-10', 'Denmark', 'LCB', 3),
    (27, 'Alejandro', 'Balde', '2003-10-18', 'Spain', 'LB', 3),
    (28, 'Ilkay', 'Gundogan', '1990-10-24', 'Germany', 'CDM', 3),
    (29, 'Frenkie', 'De Jong', '1997-05-12', 'Netherlands', 'RCM', 3),
    (30, 'Pedri', 'Gonzalez', '2002-11-25', 'Spain', 'LCM', 3),
    (31, 'Raphinha', 'Dias', '1996-12-14', 'Brazil', 'RW', 3),
    (32, 'Robert', 'Lewandowski', '1988-08-21', 'Poland', 'ST', 3),
    (33, 'João', 'Félix', '1999-11-10', 'Portgual', 'LW', 3),
    

    (34, 'Andre', 'Onana', '1996-04-02', 'Cameroon', 'GK', 4),
	(35, 'Aaron', 'Wan-Bissaka', '1997-11-26', 'England', 'RB', 4),
	(36, 'Raphael', 'Varane', '1993-04-25', 'France', 'RCB', 4),
    (37, 'Lisandro', 'Martinez', '1998-01-18', 'Argentina', 'LCB', 4),
    (38, 'Diogo', 'Dalot', '1999-03-18', 'Portgual', 'LB', 4),
    (39, 'Carlos', 'Casemiro', '1992-02-23', 'Brazil', 'CDM', 4),
    (40, 'Bruno', 'Fernandes', '1994-09-08', 'Portgual', 'RCM', 4),
    (41, 'Christian', 'Eriksen', '1992-02-14', 'Denmark', 'LCM', 4),
    (42, 'Alejandro', 'Garnacho', '2004-07-01', 'Argentina', 'RW', 4),
    (43, 'Ramsus', ' Højlund', '2003-02-04', 'Denmark', 'ST', 4),
    (44, 'Marcus', 'Rashford', '1997-10-31', 'England', 'LW', 4),
    
     (45, 'Robert', 'Sanchez', '1997-11-18', 'Spain', 'GK', 5),
     (46, 'Reece', 'James', '1999-12-08', 'England', 'RB', 5),
     (47, 'Thiago', 'Silva', '1984-09-22', 'Brazil', 'RCB', 5),
     (48, 'Trevoh', 'Chalobah', '1999-07-05', 'England', 'LCB', 5),
     (49, 'Ben', 'Chillwell', '1996-12-21', 'England', 'LB', 5),
     (50, 'Moises', 'Caicedo', '2001-11-02', 'Ecuador', 'CDM', 5),
     (51, 'Enzo', 'Fernandez', '2001-01-17', 'Argentina', 'RCM', 5),
     (52, 'Conor', 'Gallagher', '2000-02-06', 'England', 'LCM', 5),
     (53, 'Raheem', 'Sterling', '1994-12-08', 'England', 'RW', 5),
     (54, 'Nikolas', 'Jackson', '2001-06-20', 'Senegal', 'ST', 5),
     (55, 'Mykhailo', 'Mudryk', '2001-01-05', 'Ukraine', 'LW', 5),
     
     (56, 'Manuel', 'Neuer', '1986-03-27', 'Germany', 'GK', 6),
     (57, 'Noussair', 'Mazraoui', '1997-11-14', 'Morocco', 'RB', 6),
     (58, 'Dayot', 'Upamecano', '1998-10-27', 'France', 'RCB', 6),
     (59, 'Matthijs', 'De Ligt', '1999-08-12', 'Netherlands', 'LCB', 6),
     (60, 'Alphonso', 'Davies', '2000-11-02', 'Canada', 'LB', 6),
     (61, 'Joshua', 'Kimmich', '1995-02-08', 'Germany', 'CDM', 6),
     (62, 'Jamal', 'Musiala', '2003-02-26', 'Germany', 'RCM', 6),
     (63, 'Leon', 'Goretzka', '1995-02-06', 'Germany', 'LCM', 6),
     (64, 'Serge', 'Gnabry', '1995-07-14', 'Germany', 'RW', 6),
     (65, 'Harry', 'Kane', '1993-07-28', 'England', 'ST', 6),
     (66, 'Leroy', 'Sane', '1996-01-11', 'Germany', 'LW', 6),
     
     (67, 'Alisson', 'Becker', '1992-10-02', 'Brazil', 'GK', 7),
     (68, 'Trent', 'Alexander-Arnold', '1998-10-07', 'England', 'RB', 7),
     (69, 'Ibrahima', 'Konate', '1999-05-25', 'France', 'RCB', 7),
     (70, 'Virgil', 'Van Dijk', '1991-07-08', 'Netherlands', 'LCB', 7),
     (71, 'Andy', 'Robertson', '1994-03-11', 'Scotland', 'LB', 7),
     (72, 'Curtis', 'Jones', '2001-01-30', 'England', 'CDM', 7),
     (73, 'Thiago', 'Alcantara', '1991-04-11', 'Spain', 'RCM', 7),
     (74, 'Dominik', 'Szoboszlai', '2000-10-25', 'Hungary', 'LCM', 7),
     (75, 'Mohamed', 'Salah', '1992-06-15', 'Egypt', 'RW', 7),
     (76, 'Darwin', 'Nunez', '1999-06-24', 'Uruguay', 'ST', 7),
     (77, 'Luis', 'Diaz', '1997-01-13', 'Colombia', 'LW', 7),
     
     (78, 'Ederson', 'Moraes', '1993-08-17', 'Brazil', 'GK', 8),
     (79, 'Kyle', 'Walker', '1990-05-28', 'England', 'RB', 8),
     (80, 'Ruben', 'Dias', '1997-05-14', 'Portugal', 'RCB', 8),
     (81, 'Nathan', 'Ake', '1995-07-19', 'Netherlands', 'LCB', 8),
     (82, 'Manuel', 'Akanji', '1995-07-19', 'Switzerland', 'LB', 8),
     (83, 'Rodrigo', 'Hernandez', '1996-06-22', 'Spain', 'CDM', 8),
     (84, 'Bernando', 'Silva', '1994-08-10', 'Portugal', 'RCM', 8),
     (85, 'Kevin', 'De Bruyne', '1991-06-28', 'Belgium', 'LCM', 8),
     (86, 'Phil', 'Foden', '2000-05-28', 'England', 'RW', 8),
     (87, 'Erling', 'Haaland', '2000-07-21', 'Norway', 'ST', 8),
     (88, 'Jeremy', 'Doku', '2002-05-27', 'Belgium', 'LW', 8),
     
     (89, 'Wojciech', 'Szczesny', '1990-04-18', 'Poland', 'GK', 9),
     (90, 'Mattia', 'De Sciglio', '1992-10-20', 'Italy', 'RB', 9),
     (91, 'Gleison', 'Bremer', '1997-03-18', 'Brazil', 'RCB', 9),
     (92, 'Daniele', 'Rugani', '1994-07-29', 'Italy', 'LCB', 9),
     (93, 'Alex', 'Sandro', '1991-01-26', 'Brazil', 'LB', 9),
     (94, 'Manuel', 'Locatelli', '1998-01-08', 'Italy', 'CDM', 9),
     (95, 'Adrien', 'Rabiot', '1995-04-03', 'France', 'RCM', 9),
     (96, 'Weston', 'McKennie', '1998-08-28', 'USA', 'LCM', 9),
     (97, 'Moise', 'Kean', '2000-02-28', 'Italy', 'RW', 9),
     (98, 'Dusan', 'Vlahovic', '2000-01-28', 'Serbia', 'ST', 9),
     (99, 'Federico', 'Chiesa', '1997-10-25', 'Italy', 'LW', 9),
     
     (100, 'Yann', 'Sommer', '1998-12-17', 'Switzerland', 'GK', 10),
     (101, 'Matteo', 'Darmian', '1989-12-02', 'Italy', 'RB', 10),
     (102, 'Alessandro', 'Bastaoni', '1999-10-03', 'Italy', 'RCB', 10),
     (103, 'Stefan', 'de Vrij', '1992-02-05', 'Netherlands', 'LCB', 10),
     (104, 'Federico', 'Dimarco', '1997-11-10', 'Italy', 'LB', 10),
     (105, 'Hakan', 'Calhanoglu', '1994-02-08', 'Turkey', 'CDM', 10),
     (106, 'Nicolo', 'Barella', '1997-02-07', 'Italy', 'RCM', 10),
     (107, 'Henrikh', 'Mkhitaryan', '1989-01-21', 'Armenia', 'LCM', 10),
     (108, 'Juan', 'Cuadrado', '1988-05-26', 'Colombia', 'RW', 10),
     (109, 'Lautaro', 'Martinez', '1997-08-22', 'Argentina', 'ST', 10),
     (110, 'Alexis', 'Sanchez', '1988-12-19', 'Chile', 'LW', 10);
     
     
     
     
     
     
     -- My database is being recorded while the football season is going on so for now 50 matches have been played with each team atleast playing 5 times at home
     -- All of this Match info has been added to the Matches table
     INSERT INTO Matches 
	VALUES
    (1, 1, 2, '2023-01-01', 'Home Win'), -- For example: The first match was played between 1(Arsenal) and 2(Real Madrid) on 1st Jan 2023 where Arsenal(Home team) won the game.
	(2, 1, 3, '2023-01-15', 'Home Win'),
	(3, 1, 4, '2023-01-30', 'Home Win'),
	(4, 1, 6, '2023-02-11', 'Home Win'),
	(5, 1, 7, '2023-02-26', 'Draw'),
    
	(6, 2, 5, '2023-01-04', 'Draw'),
    (7, 2, 1, '2023-01-09', 'Away Win'),
    (8, 2, 8, '2023-02-12', 'Home Win'),
    (9, 2, 9, '2023-02-17', 'Home Win'),
    (10, 2, 10, '2023-02-28','Away Win'),
    
    (11, 3, 5, '2023-01-11', 'Home Win'),
    (12, 3, 8, '2023-01-23', 'Away Win'),
    (13, 3, 9, '2023-01-03', 'Home Win'),
    (14, 3, 1, '2023-02-08', 'Home Win'),
    (15, 3, 6, '2023-02-14', 'Away Win'),
    
    (16, 4, 2, '2023-01-07', 'Draw'),
    (17, 4, 10, '2023-01-19', 'Draw'),
    (18, 4, 7, '2023-01-31', 'Home Win'),
    (19, 4, 3, '2023-02-06', 'Draw'),
    (20, 4, 9, '2023-02-22', 'Draw'),
    
    (21, 5, 4, '2023-01-03', 'Away Win'),
    (22, 5, 6, '2023-01-12', 'Away Win'),
    (23, 5, 8, '2023-03-02', 'Away Win'),
    (24, 5, 10, '2023-04-16', 'Home Win'),
    (25, 5, 1, '2023-02-25', 'Away Win'),
    
    (26, 6, 9, '2023-01-13', 'Away Win'),
    (27, 6, 3, '2023-01-29', 'Home Win'),
    (28, 6, 7, '2023-02-10', 'Draw'),
    (29, 6, 5, '2023-03-06', 'Home Win'),
    (30, 6, 2, '2023-03-12', 'Draw'),
    
    (31, 7, 4, '2023-01-03', 'Home Win'),
    (32, 7, 10, '2023-02-17', 'Home Win'),
    (33, 7, 1, '2023-01-28', 'Draw'),
    (34, 7, 6, '2023-02-15', 'Away Win'),
    (35, 7, 8, '2023-03-29', 'Home Win'),
    
    (36, 8, 3, '2023-01-01', 'Draw'),
    (37, 8, 7, '2023-01-24', 'Home Win'),
    (38, 8, 5, '2023-01-23', 'Home Win'),
    (39, 8, 2, '2023-02-08', 'Away Win'),
    (40, 8, 9, '2023-03-11', 'Away Win'),
    
    (41, 9, 10, '2023-01-15', 'Home Win'),
    (42, 9, 2, '2023-01-15', 'Home Win'),
    (43, 9, 1, '2023-01-15', 'Away Win'),
    (44, 9, 4, '2023-01-15', 'Home Win'),
    (45, 9, 6, '2023-01-15', 'Draw'),
    
    (46, 10, 3, '2023-01-03', 'Draw'),
    (47, 10, 5, '2023-02-18', 'Home Win'),
    (48, 10, 8, '2023-02-27', 'Home Win'),
    (49, 10, 7, '2023-03-03', 'Home Win'),
    (50, 10, 9, '2023-03-12', 'Draw');
    
    -- The goals across the 50 matches have been inserted into the Goals table
    INSERT INTO Goals
    VALUES
    (1,1,9,8,27), -- The values from the Goals table can be interpreted as: The first goal(1) of the season was scored in the first game(1) by 9(Bukayo Saka) and assisted by 8(Martin Ødegaard) in the 27th minute.
	(2,1,11,10,51),
	(3,1,9,6,78),

	(4,2,10,7,12),
	(5,2,32,29,34),
	(6,2,4,9,49),
	(7,2,8,11,81),
		
    (8,4,11,6,45),

	(9,4,8,10,21),
	(10,4,11,5,67),

	(11,5,75,73,26),
	(12,5,6,8,79),
    
    (13,6,21,19,32),
	(14,6,21,22,67),
	(15,6,53,55,73),
	(16,6,50,51,84),

	(17,7,22,20,28),
	(18,7,9,8,51),
	(19,7,9,11,66),

	(20,8,19,13,39),
	(21,8,21,17,72),

	(22,9,98,95,23),
	(23,9,15,18,67),
	(24,9,22,21,73),

	(25,10,110,108,58),
    
    (26,11,32,30,17),
	(27,11,31,27,58),

	(28,12,87,85,17),
	(29,12,87,84,44),
	(30,12,87,86,82),

	(31,13,98,99,3),
	(32,13,30,28,53),
	(33,13,33,32,64),

	(34,14,32,28,9),
	(35,15,65,62,16),
	(36,15,66,64,58),
    
    (37,16,43,44,21),
	(38,16,20,18,42),
	(39,16,21,16,55),
	(40,16,40,44,75),

	(41,17,44,41,26),
	(42,17,107,105,87),

	(43,18,40,38,27),
	(44,18,43,40,68),

	(45,20,39,42,36),
	(46,20,99,94,73),
    
    (47,21,47,46,6),
	(48,21,36,41,38),
	(49,21,43,42,62),
	(50,21,39,44,73),
	(51,21,53,52,84),

	(52,22,63,60,33),
	(53,22,65,62,75),

	(54,23,85,88,22),
	(55,23,87,81,52),

	(56,24,54,46,19),

	(57,25,8,6,5),
	(58,25,11,9,32),
	(59,25,10,11,68),
	(60,25,8,5,84),
    
    (61,26,61,59,62),
	(62,26,95,93,73),
	(63,26,98,97,85),

	(64,27,64,61,22),
	(65,27,65,63,47),
	(66,27,59,66,73),
	(67,27,29,31,81),

	(68,28,75,73,19),
	(69,28,63,60,43),
	(70,28,66,65,56),
	(71,28,76,74,78),

	(72,29,62,66,32),
	(73,29,65,66,53),

	(74,30,65,57,28),
	(75,30,22,16,63),
    
    (76,31,75,68,8),
	(77,31,75,77,15),
	(78,31,76,74,31),
	(79,31,75,71,67),

	(80,32,74,72,31),
	(81,32,76,77,65),
	(82,32,107,108,78),

	(83,33,75,77,23),
	(84,33,11,10,71),

	(85,34,66,64,21),
	(86,34,65,62,83),

	(87,35,77,72,34),
	(88,35,87,85,53),
	(89,35,75,73,86),
    
    (90,36,88,84,21),
	(91,36,31,32,43),
	(92,36,84,83,68),
	(93,36,28,26,76),

	(94,37,86,85,32),
	(95,37,87,79,68),

	(96,38,82,79,26),
	(97,38,85,87,42),
	(98,38,53,50,53),

	(99,39,21,19,45),
	(100,39,18,17,62),
	(101,39,88,83,72),

	(102,40,96,99,32),
    
    (103,41,108,104,11),
	(104,41,94,93,34),
	(105,41,98,99,54),
	(106,41,90,98,72),

	(107,42,95,98,25),
	(108,42,99,96,63),
	(109,42,21,20,78),

	(110,43,6,8,35),
	(111,43,3,9,59),
	(112,43,5,9,71),

	(113,44,93,95,21),
	(114,44,98,99,49),

	(115,45,91,94,51),
	(116,45,65,63,84),

	(117,47,109,110,5),
	(118,47,109,107,43),
	(119,47,109,106,83),

	(120,48,110,109,26),
	(121,48,84,80,39),
	(122,48,105,107,76),

	(123,49,109,104,31),
	(124,49,110,108,48),

	(125,50,96,95,29),
	(126,50,98,94,43),
	(127,50,109,107,62),
	(128,50,107,103,69);

    


