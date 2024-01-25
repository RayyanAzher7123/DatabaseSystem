-- Query 1 :A simple SELECT query from Players table of Players info that are English and outfield(Not GK),ordered ascending by their First Name
SELECT * FROM Players 
WHERE Nationality = "England" AND Position <> "GK"
ORDER BY FirstName;
    
-- QUERY 2: This query INNER JOINS Players and Teams table to display the player's teams that start with 'Manchester'
SELECT Players.PlayerID, Players.FirstName, Players.LastName, Players.TeamID, Teams.TeamName
FROM Players INNER JOIN Teams USING (TeamID)
WHERE Teams.TeamName LIKE "Manchester%";
    
-- QUERY-3: This query prints the first name,last name and most goals scored from players(goals scored should be more than two)
SELECT P.FirstName,P.LastName,COUNT(G.GoalID) AS GoalsScored
FROM Players P LEFT JOIN Goals G ON P.PlayerID = G.ScorerPlayerID
GROUP BY P.FirstName,P.LastName
HAVING GoalsScored > 2
ORDER BY GoalsScored DESC;

-- Query 4: Subquery in the FROM clause to find players from Teams founded after 1900.
SELECT FirstName,LastName,Position,TeamName,FoundedYear
FROM(
SELECT TeamID,TeamName,FoundedYear
FROM Teams
WHERE FoundedYear > 1900
) AS LatestTeams
INNER JOIN Players ON LatestTeams.TeamID = Players.TeamID
Order by FoundedYear;

-- Query 5: We create a view that contains information on all the goals scored this season

-- Step-1:Creates a VIEW from two or more tables, including derived attributes
DROP VIEW IF EXISTS MatchGoalView;
CREATE VIEW MatchGoalView AS
SELECT
    P.PlayerID,
    P.FirstName,
    P.LastName,
    M.MatchID,
    M.MatchDate,
    G.GoalID,
    G.MinuteScored
FROM
    Players P
JOIN
    Goals G ON P.PlayerID = G.ScorerPlayerID
JOIN
    Matches M ON G.MatchID = M.MatchID;
    
-- Step-2:Runs a SELECT query on the view
SELECT * FROM MatchGoalView;

-- Step-3: Modifies one of the underlying tables
-- The 3rd goal scored this season was changed to the 79th minute due to stoppage time
UPDATE Goals
SET MinuteScored = 79
WHERE GoalID = 3;

-- Step-4: Re-run the SELECT query on the view, reflecting changes in the underlying tables and the derived attributes
SELECT * FROM MatchGoalView;