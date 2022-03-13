EXPLAIN ANALYZE
SELECT t.physician, a.phy_name, a.dept_name, t.procedure_name FROM dup_affiliated_with a
JOIN trained_in t
ON a.physician = t.physician 
WHERE t.procedure_name = 'Follicular Demiectomy'
ORDER BY t.physician