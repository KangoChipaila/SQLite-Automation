CREATE TRIGGER UpdateGradeDistribution_Insert
AFTER INSERT 
ON Enrollments
FOR EACH ROW
BEGIN 
	UPDATE GradeDistribution
	SET 
		A_Count = (
			SELECT COUNT(*)
			FROM Enrollments 
			WHERE Grade = "A" AND CourseID = NEW.CourseID),
			
		B_Count = (
			SELECT COUNT(*)
			FROM Enrollments 
			WHERE Grade = "B" AND CourseID = NEW.CourseID),
			
		C_Count = (
			SELECT COUNT(*)
			FROM Enrollments 
			WHERE Grade = "C" AND CourseID = NEW.CourseID),
			
		D_Count = (
			SELECT COUNT(*)
			FROM Enrollments 
			WHERE Grade = "D" AND CourseID = NEW.CourseID),
			
		F_Count = (
			SELECT COUNT(*)
			FROM Enrollments 
			WHERE Grade = "F" AND CourseID = NEW.CourseID)
			
		WHERE CourseID = NEW.CourseID;
END