CREATE TRIGGER AfterInsertStudent
BEFORE INSERT
ON Students
FOR EACH ROW
BEGIN
	SELECT 
		CASE WHEN (SELECT COUNT (*) FROM Students WHERE Email = NEW.Email) > 0 
		THEN RAISE (FAIL, "Duplicate Email Found") 
		ELSE 1 
	END; 
END