# SQL Lab Assignment – UPDATE and DELETE

## Objective

To learn how to modify and delete records using SQL `UPDATE` and `DELETE` commands.

## Problem Statement

The `Student` table and the following records already exist:

| StudentID | StudentName | Gender | DepartmentID |
|---|---|---|---:|
| 1001 | Arun | Male | 101 |
| 1002 | Divya | Female | 102 |
| 1003 | Karthik | Male | 101 |

Perform the following operations:

1. Update Karthik's `DepartmentID` from `101` to `103`.
2. Delete the student record with `StudentID = 1002`.
3. Display all remaining student records.

## Instructions

1. Open `student_solution.sql`.
2. Do not create the `Student` table again.
3. Do not insert the initial records again.
4. Write an `UPDATE` statement to change Karthik's department to `103`.
5. Write a `DELETE` statement to delete the student with `StudentID = 1002`.
6. Use `SELECT * FROM Student;` to display the remaining records.
7. Do not rename `student_solution.sql`.
8. Do not modify `test.sh`.
9. Do not modify the `.github` folder.
10. Commit and push your changes.
11. Check the **Actions** tab for your marks.

## Marks

| Test | Marks |
|---|---:|
| Karthik record exists | 2 |
| Karthik updated to DepartmentID 103 | 4 |
| StudentID 1002 deleted | 3 |
| Other records preserved | 1 |
| **Total** | **10** |
