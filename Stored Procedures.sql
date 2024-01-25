-- Stored Procedure 1: UpdatePlayerAndMatch
-- This procedure updates a player's information and the corresponding match result
DELIMITER //
CREATE PROCEDURE UpdatePlayerAndMatch(
    IN playerID_param INT,
    IN newFirstName_param VARCHAR(100),
    IN newLastName_param VARCHAR(100),
    IN newDateOfBirth_param DATE,
    IN newNationality_param VARCHAR(50),
    IN newPosition_param VARCHAR(50), 
    OUT success_flag INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SET success_flag = 0;
    END;
    START TRANSACTION;

    -- Update player information
    UPDATE Players
    SET FirstName = newFirstName_param,
        LastName = newLastName_param,
        DateOfBirth = newDateOfBirth_param,
        Nationality = newNationality_param,
        Position = newPosition_param
    WHERE PlayerID = playerID_param;

    -- A match result change due to player update
    UPDATE Matches
    SET Result = 'Home Win'
    WHERE HomeTeamID = (SELECT TeamID FROM Players WHERE PlayerID = playerID_param)
        OR AwayTeamID = (SELECT TeamID FROM Players WHERE PlayerID = playerID_param);

    COMMIT;
    SET success_flag = 1;
END //

DELIMITER ;

-- Call the first procedure
CALL UpdatePlayerAndMatch(1, 'Aaron', 'Ramsdale', '1998-05-14','England','GK', @update_success);
SELECT @update_sucess AS UpdatePlayerSuccess;


-- Stored Procedure 2: UpdateMatchResult
-- This procedure updates the transfered players and remove their goal contributions of the previous team
DELIMITER //

CREATE PROCEDURE TransferPlayer(
    IN playerID_param INT,
    IN newTeamID_param INT,
    OUT success_flag INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET success_flag = 0;
    END;

    START TRANSACTION;

    -- Update transfer player's new team
    UPDATE Players
    SET TeamID = newTeamID_param
    WHERE PlayerID = playerID_param;
    
    -- Delete the player's contributions for goals if he transfers
    DELETE FROM Goals
    WHERE ScorerPlayerID = playerID_param
    OR AssistPlayerID = playerID_param;

    COMMIT;
    SET success_flag = 1;
END //

DELIMITER ;

-- Call the second procedure
CALL TransferPlayer(10, 2, @transfer_player_success);
SELECT @transfer_player_success AS TransferPlayerSuccess;

