
-- Q1 returns (name,dod)
--SELECT personb.name, personb.dod
--FROM person AS persona CROSS JOIN person AS personb
--AND persona.dod IS NOT NULL

;


-- Q2 returns (name)
SELECT DISTINCT person.father, person.mother,
ROUND (
  ( (COUNT (CASE WHEN person.gender = 'M' THEN person.name END) * 100 )  /
  COUNT(person.name)
) ) AS male

FROM person
WHERE (person.mother IS NOT NULL
AND person.father IS NOT NULL)

GROUP BY person.father, person.mother
ORDER BY person.father, person.mother

;



--SELECT persona.name
--FROM person AS persona CROSS JOIN person AS personb
--WHERE persona.gender = 'M'
--EXCEPT
--SELECT persona.name
--FROM person AS persona CROSS JOIN person AS personb
--WHERE persona.gender = 'M'
--EXCEPT
--SELECT persona.name
--FROM person AS persona CROSS JOIN person AS personb
--WHERE persona.name=personb.father

--SELECT persona.name FROM person AS persona CROSS JOIN person AS personb
--WHERE persona.gender = "M"
--EXCEPT
--SELECT persona.name FROM person AS persona CROSS JOIN person AS personb
--WHERE persona.name = personb.father

-- Q3 returns (name)

--SELECT DISTINCT name
--FROM person AS persona
--WHERE NOT EXISTS (
--        SELECT gender
--        FROM person
--        EXCEPT
--        SELECT gender
--        FROM person
--        WHERE person.name = persona.mother
--      )

;

-- Q4 returns (name,father,mother)
--SELECT DISTINCT oldestsib_table.name, oldestsib_table.mother, oldestsib_table.father
--FROM (
--SELECT DISTINCT person.name, persona.father, persona.mother
--FROM person AS persona CROSS JOIN person
--WHERE persona.name <> person.name
--AND persona.mother = person.mother
--AND persona.father = person.father

--EXCEPT

--SELECT DISTINCT person.name, persona.father, persona.mother
--FROM person AS persona CROSS JOIN person
--WHERE persona.name <> person.name
--AND persona.mother = person.mother
--AND persona.father = person.father
--AND person.dob < ALL (SELECT persona.dob FROM person WHERE persona.dob > person.dob)
--everyone but the youngest
--AND person.dob > ALL (SELECT persona.dob FROM person WHERE persona.dob > person.dob)

--) oldestsib_table
--ORDER BY oldestsib_table.name
--everyone but the oldest
;

-- Q5 returns (name,popularity)
--SELECT firstname, COUNT(firstname) AS popularity
--FROM ( SELECT SUBSTRING(name FROM '[a-zA-Z]+') AS firstname
--      FROM person ) AS firstnametable
--GROUP BY firstname
--HAVING COUNT(firstname)>1
---ORDER BY popularity DESC
;

-- Q6 returns (name,forties,fifties,sixties)
--SELECT parent.name AS PARENTNAME,
--    COUNT(person.name) AS numberofchildren,
--    COUNT(CASE WHEN person.dob <='1950-01-01' AND person.dob >='1939-12-31' THEN person.dob ELSE NULL END) AS forties,
---    COUNT(CASE WHEN person.dob <='1960-01-01' AND person.dob >='1949-12-31' THEN person.dob ELSE NULL END) AS fifties,
--    COUNT(CASE WHEN person.dob <='1970-01-01' AND person.dob >='1959-12-31' THEN person.dob ELSE NULL END) AS sixties
--FROM person AS parent CROSS JOIN person
--WHERE parent.name=person.mother
--OR parent.name=person.father
--GROUP BY parent.name
--HAVING COUNT(person.name) >= 2
;


-- Q7 returns (father,mother,child,born)
--SELECT     persona.father AS father,
--    persona.mother AS mother,
--    persona.name AS child,
--    RANK() OVER (PARTITION BY persona.father ORDER by persona.dob) AS born
--FROM     person inner JOIN person AS persona
--ON     persona.father = person.name
--OR     persona.mother = person.name
--GROUP BY persona.father, persona.mother, persona.name, persona.dob

;

-- Q8 returns (father,mother,male)

--SELECT DISTINCT person.father, person.mother,
--ROUND (
--  ( (COUNT (CASE WHEN person.gender = 'M' THEN person.name END) * 100 )  /
--  COUNT(person.name)
--) ) AS male

--FROM person
--WHERE (person.mother IS NOT NULL
--AND person.father IS NOT NULL)

--GROUP BY person.father, person.mother
--ORDER BY person.father, person.mother

--COUNT (person.name) AS childcount
--FROM person AS persona CROSS JOIN person
--WHERE persona.name <> person.name
--AND persona.mother = person.mother
--AND persona.father = person.father
--ORDER BY persona.father, persona.mother
--GROUP BY persona.father, persona.mother










;
