
-- Q1 returns (name,dod)
SELECT personb.name, persona.dod
FROM person AS persona CROSS JOIN person AS personb
WHERE persona.name = personb.mother
AND persona.dod IS NOT NULL

;


-- Q2 returns (name)
SELECT persona.name
FROM person AS persona CROSS JOIN person AS personb
WHERE persona.gender = 'M'
EXCEPT
SELECT persona.name
FROM person AS persona CROSS JOIN person AS personb
WHERE persona.name=personb.father

ORDER BY name


;

-- Q3 returns (name)
SELECT DISTINCT persona.name
FROM person AS persona
WHERE NOT EXISTS (

        SELECT gender
        FROM person
        EXCEPT
        SELECT gender
        FROM person
        WHERE persona.name = person.mother

      )

ORDER BY persona.name


;

-- Q4 returns (name,father,mother)
SELECT DISTINCT oldestsib_table.name, oldestsib_table.mother, oldestsib_table.father
FROM (
      SELECT DISTINCT person.name, persona.father, persona.mother
      FROM person AS persona CROSS JOIN person
      WHERE persona.name <> person.name
      AND persona.mother = person.mother
      AND persona.father = person.father

EXCEPT

      SELECT DISTINCT person.name, persona.father, persona.mother
      FROM person AS persona CROSS JOIN person
      WHERE persona.name <> person.name
      AND persona.mother = person.mother
      AND persona.father = person.father

AND person.dob > ALL (SELECT persona.dob FROM person WHERE persona.dob > person.dob)

) oldestsib_table

ORDER BY oldestsib_table.name
;

-- Q5 returns (name,popularity)
SELECT name, COUNT(name) AS popularity
FROM (
      SELECT SUBSTRING(name FROM '[a-zA-Z]+') AS name
      FROM person
    ) AS firstnametable
GROUP BY name
HAVING COUNT(name)>1

ORDER BY popularity DESC, name
;

-- Q6 returns (name,forties,fifties,sixties)
SELECT parent.name AS name,
    COUNT(CASE WHEN     (person.dob <='1950-01-01' AND person.dob >='1939-12-31')
                     OR (person.dob  <='1850-01-01' AND person.dob >='1839-12-31' )
                     OR (person.dob  <='1750-01-01' AND person.dob >='1739-12-31' )
                     OR (person.dob  <='1650-01-01' AND person.dob >='1639-12-31' )
                     THEN person.dob ELSE NULL END) AS forties,

    COUNT(CASE WHEN     (person.dob <='1960-01-01' AND person.dob >='1949-12-31')
                     OR (person.dob  <='1860-01-01' AND person.dob >='1849-12-31' )
                     OR (person.dob  <='1760-01-01' AND person.dob >='1749-12-31' )
                     OR (person.dob  <='1660-01-01' AND person.dob >='1649-12-31' )
                     THEN person.dob ELSE NULL END) AS fifties,

    COUNT(CASE WHEN    (person.dob <='1970-01-01' AND person.dob >='1959-12-31')
                    OR (person.dob  <='1870-01-01' AND person.dob >='1859-12-31' )
                    OR (person.dob  <='1770-01-01' AND person.dob >='1759-12-31' )
                    OR (person.dob  <='1670-01-01' AND person.dob >='1659-12-31' )
                    THEN person.dob ELSE NULL END) AS sixties

FROM person AS parent CROSS JOIN person
WHERE parent.name=person.mother
OR parent.name=person.father
GROUP BY parent.name
HAVING COUNT(person.name) >= 2

ORDER BY parent.name
;


-- Q7 returns (father,mother,child,born)
SELECT persona.father AS father,
       persona.mother AS mother,
       persona.name AS child,
       RANK() OVER (PARTITION BY persona.father ORDER by persona.dob) AS born
FROM   person inner JOIN person AS persona
ON     persona.father = person.name
OR     persona.mother = person.name

GROUP BY persona.father, persona.mother, persona.name, persona.dob
ORDER BY persona.father, persona.mother, born
;

-- Q8 returns (father,mother,male)
SELECT DISTINCT person.father, person.mother,
ROUND (
        ( (COUNT (CASE WHEN person.gender = 'M' THEN person.name END) * 100 )  /
        COUNT(person.name) )
     ) AS male
FROM person
WHERE (person.mother IS NOT NULL
AND person.father IS NOT NULL)

GROUP BY person.father, person.mother
ORDER BY person.father, person.mother
;
