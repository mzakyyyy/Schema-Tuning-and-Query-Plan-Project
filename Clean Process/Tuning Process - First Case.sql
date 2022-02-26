-- Kasus 1 Schema Tuning
	-- Adding redundant column yaitu nama dari department akan ditambahkan ke table affiliated_with
	-- Sehingga, dengan penambahan ini bisa mengurangi jumlah join
		-- Duplicating Table affiliated_with
		CREATE TABLE dup_affiliated_with
		AS (SELECT * FROM affiliated_with);
		-- Create kolom dept_name
		ALTER TABLE dup_affiliated_with
		ADD COLUMN dept_name VARCHAR(30);
		-- Pindahkan data department name ke table affiliated_with
		UPDATE dup_affiliated_with
		SET dept_name = s1.name
		FROM(SELECT aw.department as department,d.name  FROM dup_affiliated_with aw, department d WHERE aw.department = d.departmentid) AS s1
		WHERE dup_affiliated_with.department = s1.department;	
		
	-- Adding redundat column yaitu nama dari physician akan ditambahkan ke table affiliated_with
	-- Sehingga, dengan penambahan ini bisa mengurangi jumlah join

		-- Create kolom phy_name
		ALTER TABLE dup_affiliated_with
		ADD COLUMN phy_name VARCHAR(30);
		-- Pindahkan data physician name ke table affiliated_with
		UPDATE dup_affiliated_with
		SET phy_name = subquery.name
		FROM(SELECT aw.physician as phy, p.name FROM dup_affiliated_with aw, physician p WHERE aw.physician = p.employeeid) AS subquery 
		WHERE dup_affiliated_with.physician  = subquery.phy;
		
	-- Adding redundant column yaitu certificationDate ditambahkan ke table dup_affiliated_with
		-- Create kolom certificationDate
		ALTER TABLE dup_affiliated_with
		ADD COLUMN certificationDate TIMESTAMP;
		-- Pindahkan data certificationDate ke table dup_affiliated_with
		UPDATE dup_affiliated_with
		SET certificationDate = s1.certificationdate
		FROM(SELECT ti.physician as physician , ti.certificationdate   FROM trained_in ti, physician p WHERE ti.physician = p.employeeid) AS s1
		WHERE dup_affiliated_with.physician = s1.physician;
	
	-- Melakukan horizontal splitting
		-- Membuat table affiliated_with_certified
		CREATE TABLE affiliated_with_certified AS
		(SELECT * FROM dup_affiliated_with WHERE certificationDate IS NOT NULL);
		-- Membuat table affiliated_with_uncertified
		CREATE TABLE affiliated_with_uncertified AS
		(SELECT * FROM dup_affiliated_with WHERE certificationDate IS NULL);
		
	-- Create Index
	CREATE INDEX dept_name ON dup_affiliated_with(dept_name);