-- Query Kasus 1
EXPLAIN ANALYZE
SELECT p.name
FROM physician p, affiliated_with aw, trained_in ti, department d  
WHERE p.employeeid = aw.physician AND aw.department = d.departmentid AND p.employeeid = ti.physician AND d.name = 'Surgery';