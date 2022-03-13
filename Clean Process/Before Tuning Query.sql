EXPLAIN ANALYZE
SELECT p.employeeid, p.name, d.name, pr.name FROM physician p
JOIN affiliated_with aw
ON p.employeeid = aw.physician
JOIN department d
ON aw.department = d.departmentid
JOIN trained_in ti
ON p.employeeid = ti.physician
JOIN procedures pr
ON ti.treatment = pr.code
WHERE pr.name = 'Follicular Demiectomy'