-- Query Kasus 1
EXPLAIN ANALYZE
SELECT p.name
FROM physician p, affiliated_with aw, trained_in ti, department d  
WHERE p.employeeid = aw.physician AND aw.department = d.departmentid AND p.employeeid = ti.physician AND d.name = 'Surgery';

-- Query Kasus 2
SELECT m.name, SUM(CAST(p.dose AS INTEGER)), DATE_PART(‘MONTH’, p.date) AS BULAN, DATE_PART(‘YEAR’, p.date) AS TAHUN
FROM prescribes p 
JOIN medication m 
ON p.medication = m.code
GROUP BY m.code, DATE_PART(‘MONTH’, p.date), DATE_PART(‘YEAR’, p.date)
ORDER BY DATE_PART(‘YEAR’, p.date), date_part(‘MONTH’, p.date);
