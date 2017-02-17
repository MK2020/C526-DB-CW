
-- Q1 returns (name,dod)
SELECT personb.name, personb.dod
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
WHERE personsa.gender = 'M'
EXCEPT
SELECT persona.name
WHERE persona.name=personb.father
;

-- Q3 returns (name)
SELECT DISTINCT name
FROM person AS persona
WHERE NOT EXISTS (
        SELECT gender
        FROM person
        EXCEPT
        SELECT gender
        FROM person
        WHERE person.name = persona.mother
      )



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
--AND person.dob < ALL (SELECT persona.dob FROM person WHERE persona.dob > person.dob)
--everyone but the youngest
AND person.dob > ALL (SELECT persona.dob FROM person WHERE persona.dob > person.dob)

) oldestsib_table
ORDER BY oldestsib_table.name

----------------------------TABLE4------------------------------------

name            |      mother       |   father
---------------------------+-------------------+------------
Albert Victor             | Alexandra (Queen) | Edward VII
Charles                   | Elizabeth II      | Philip
Charles II                | Henrietta Maria   | Charles I
Edward VIII               | Mary of Teck      | George V
Elizabeth II              | Elizabeth         | George VI
Frederick (Prince)        | Charlotte         | George III
Mary II                   | Anne Hyde         | James II
Victoria (Princess Royal) | Victoria          | Albert
William                   | Diana             | Charles
(9 rows)


-------------------------------------------------------------------------

;

-- Q5 returns (name,popularity)
SELECT firstname, COUNT(firstname) AS popularity
FROM ( SELECT SUBSTRING(name FROM '[a-zA-Z]+') AS firstname
      FROM person ) AS firstnametable
GROUP BY firstname
HAVING COUNT(firstname)>1
ORDER BY popularity DESC
;

-- Q6 returns (name,forties,fifties,sixties)
SELECT parent.name AS PARENTNAME,
    COUNT(person.name) AS numberofchildren,
    COUNT(CASE WHEN person.dob <='1950-01-01' AND person.dob >='1939-12-31' THEN person.dob ELSE NULL END) AS forties,
    COUNT(CASE WHEN person.dob <='1960-01-01' AND person.dob >='1949-12-31' THEN person.dob ELSE NULL END) AS fifties,
    COUNT(CASE WHEN person.dob <='1970-01-01' AND person.dob >='1959-12-31' THEN person.dob ELSE NULL END) AS sixties
FROM person AS parent CROSS JOIN person
WHERE parent.name=person.mother
OR parent.name=person.father
GROUP BY parent.name
HAVING COUNT(person.name) >= 2
;


-- Q7 returns (father,mother,child,born)

;

-- Q8 returns (father,mother,male)

;
