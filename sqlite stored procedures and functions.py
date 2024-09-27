import sqlite3 

def insert_grade():

    con = sqlite3.connect("C:/sqlite/StudentManagement.db") #connect to db by specifying path
    cur = con.cursor() #create cursor to interact with db

    grade = input("Enter the student's new grade: ")
    student_ID = input("student ID: ")
    course_ID = input("The course ID: ")

    query = """UPDATE Enrollments 
                SET Grade = ? 
                WHERE StudentID = ? AND CourseID = ?"""
    
    cur.execute(query, (grade, student_ID, course_ID)) #Execute SQL command

    con.commit() #Commit transaction

    cur.close() # Close cursor
    con.close() # Close connection

def enroll_student_in_course():

    con = sqlite3.connect("C:/sqlite/StudentManagement.db")
    cur = con.cursor()

    enrollment_ID = input("Enter the student's enrollment ID: ")
    student_ID = input("Enter the student's ID: ")
    course_ID = input("Enter the ID of the course you are enrolling the student in: ")
    enrollment_date = input("Enter the date of this enrollment (form: YYYY-MM-DD): ")
    grade = input("Enter the student's grade in this enrollment: ")

    query = """INSERT INTO Enrollments VALUES (?, ?, ?, ?, ?)"""
    
    cur.execute(query, (enrollment_ID, student_ID, course_ID, enrollment_date, grade))

    con.commit()

    cur.close()
    con.close()

def total_credits_earned(student_ID):

    grade_values = {'A': 1, 'B': 0.8, 'C': 0.6, 'D': 0.4, 'F': 0.2}
    total_credits = 0

    con = sqlite3.connect("C:/sqlite/StudentManagement.db")
    cur = con.cursor()

    query = ("""SELECT Enrollments.Grade, Courses.Credits
                FROM Enrollments
                INNER JOIN Courses
                ON Enrollments.CourseID = Courses.CourseID
                WHERE StudentID = ? 
             """)
    
    res = cur.execute(query, (student_ID,))

    for i in res.fetchall():
        total_credits += grade_values.get(i[0]) * i[1]

    cur.close()
    con.close()

    return total_credits

def course_enrollment_count(course_ID):
    
    con = sqlite3.connect("C:/sqlite/StudentManagement.db")
    cur = con.cursor()

    query = """SELECT *
                FROM Enrollments
                WHERE CourseID = ?
            """
    res = cur.execute(query, (course_ID,))
    number_of_students_enrolled = res.fetchall()

    cur.close()
    con.close()

    return len(number_of_students_enrolled)

    

print("""\nWhich stored procedure/function would you like to execute?
    
    Enter corresponding number for desired option 
    e.g Enter 1 for InsertGrade

    STORED PROCEDURES

    1. InsertGrade
    2. EnrollStudentInCourse

    FUNCTIONS

    3. TotalCreditsEarned
    4. CourseEnrollmentCount

    """)

option = int(input("Option: "))

match option:
    case 1:
        insert_grade()
    case 2:
        enroll_student_in_course()
    case 3:
        s_ID = input("Enter the student's ID: ")
        total_credits_earned(s_ID) 
    case 4:
        c_ID = input("Enter the course ID: ")
        course_enrollment_count(c_ID)
    case _:
        print("Invalid option.")
    