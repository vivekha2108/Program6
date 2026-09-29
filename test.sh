#!/bin/bash

MYSQL="mysql -h127.0.0.1 -P3306 -uroot -proot"

echo "========================================"
echo " UPDATE and DELETE - Student Assignment"
echo "========================================"

# Check student solution file
if [ ! -f "student_solution.sql" ]; then
    echo "FAIL: student_solution.sql file not found."
    exit 1
fi

echo "Creating fresh CollegeDB database..."

# Create fresh database
$MYSQL -e "DROP DATABASE IF EXISTS CollegeDB;"
$MYSQL -e "CREATE DATABASE CollegeDB;"

echo "Creating Student table and inserting records..."

# Create table and initial records
$MYSQL CollegeDB <<EOF
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(20),
    Gender VARCHAR(10),
    DepartmentID INT
);

INSERT INTO Student VALUES
(1001, 'Arun', 'Male', 101),
(1002, 'Divya', 'Female', 102),
(1003, 'Karthik', 'Male', 101);
EOF

echo "Executing student_solution.sql..."

# Execute student SQL
if ! $MYSQL CollegeDB < student_solution.sql; then
    echo "FAIL: Error while executing student_solution.sql"
    exit 1
fi

echo ""
echo "Checking UPDATE and DELETE operations..."
echo ""

MARKS=0

# ----------------------------------------
# Test Case 1: Karthik record exists
# ----------------------------------------

KARTHIK=$($MYSQL -N -s CollegeDB -e "
SELECT COUNT(*)
FROM Student
WHERE StudentID=1003
AND StudentName='Karthik';
")

if [ "$KARTHIK" -eq 1 ]; then
    echo "PASS: Karthik record exists."
    MARKS=$((MARKS+2))
else
    echo "FAIL: Karthik record not found."
fi

# ----------------------------------------
# Test Case 2: Karthik DepartmentID = 103
# ----------------------------------------

DEPT=$($MYSQL -N -s CollegeDB -e "
SELECT DepartmentID
FROM Student
WHERE StudentID=1003;
")

if [ "$DEPT" = "103" ]; then
    echo "PASS: Karthik DepartmentID updated to 103."
    MARKS=$((MARKS+4))
else
    echo "FAIL: Karthik DepartmentID was not updated to 103."
fi

# ----------------------------------------
# Test Case 3: Divya deleted
# ----------------------------------------

DIVYA=$($MYSQL -N -s CollegeDB -e "
SELECT COUNT(*)
FROM Student
WHERE StudentID=1002;
")

if [ "$DIVYA" -eq 0 ]; then
    echo "PASS: StudentID 1002 deleted successfully."
    MARKS=$((MARKS+3))
else
    echo "FAIL: StudentID 1002 still exists."
fi

# ----------------------------------------
# Test Case 4: Arun remains
# ----------------------------------------

ARUN=$($MYSQL -N -s CollegeDB -e "
SELECT COUNT(*)
FROM Student
WHERE StudentID=1001
AND StudentName='Arun';
")

if [ "$ARUN" -eq 1 ]; then
    echo "PASS: Other student records preserved."
    MARKS=$((MARKS+1))
else
    echo "FAIL: Other student records were modified."
fi

echo ""
echo "========================================"
echo "Remaining Student Records"
echo "========================================"

$MYSQL CollegeDB -e "SELECT * FROM Student;"

echo ""
echo "========================================"
echo "Total Marks: $MARKS / 10"
echo "========================================"

if [ "$MARKS" -eq 10 ]; then
    echo "SUCCESS: All test cases passed."
    exit 0
else
    echo "Some test cases failed."
    exit 1
fi
