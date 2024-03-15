# Task Topic
School trips: type (entertainment /educational), disciplines to which the educational excursion is related, cost per person, list of participants, teacher responsible for conducting.
# Implemented requests:
- excursions to the shipyard (the word "shipyard" anywhere in the name)
- excursions related to biology and geography
- teachers not responsible for excursions
- students, who did not go to the Museum of the History of religion, but went to the Hermitage
- the teacher who was responsible for the number of excursions above the average
- the teachers responsible for the most expensive excursions
- Excursions that all students went to
# Table of estimated query results
| **Request text** | **Data that meets the query conditions** | **Data that does not meet the query conditions** |
|:-:|:-:|:-:|
|Excursions to the shipyard (the word "shipyard" anywhere in the name)|excursion_name: Реки и каналы Санкт-Петербурга(верфь)|excursion_name: Эрмитаж|
|Excursions related to biology and geography|excursion_name: Зоологический Музей |excursion_name: Эрмитаж|
|Teachers not responsible for excursions|  |  |
|Students, who did not go to the Museum of the History of religion, but went to the Hermitage|  |  |
|The teacher who was responsible for the number of excursions above the average|  |  |
|The teachers responsible for the most expensive excursions|  |  |
|Excursions that all students went to|  |  |


## 1)Excursions to the shipyard (the word "shipyard" anywhere in the name)
```SQL
SELECT excursion_name FROM excursion
   WHERE excursion_name LIKE '%верфь%'
  ```
   ### Output
   ![image](https://github.com/KoWalevDV/Data-Base-2023-2024/assets/127125663/319cb7be-ca05-42b0-8206-5cbaf288cc02)

## 2)Excursions related to biology and geography
```SQL
SELECT Distinct e.excursion_name 
FROM excursion e
JOIN excursion_discipline ed1 ON e.excursion_id = ed1.excursion_id
JOIN discipline_type d1 ON ed1.discipline_id = d1.discipline_id 
JOIN excursion_discipline ed2 ON e.excursion_id = ed2.excursion_id
JOIN discipline_type d2 ON ed2.discipline_id = d2.discipline_id  
WHERE d1.discipline_name = 'Биология' And d2.discipline_name = 'География' ;
```
### Output
![image](https://github.com/KoWalevDV/Data-Base-2023-2024/assets/127125663/fe541d93-2acc-4e15-af6a-360e598ea418)

## 3)Teachers not responsible for excursions
```SQL
SELECT t.teacher_name, t.teacher_secondname
FROM teacher t
LEFT JOIN list_of_participants lp ON t.teacher_id = lp.teacher_id
WHERE lp.isavailable IS NULL OR lp.isavailable ='false';
```
### Output
![image](https://github.com/KoWalevDV/Data-Base-2023-2024/assets/127125663/c731ec22-3f7b-45c0-91d3-3e1c2f2c9eb7)
# The following requests will be implemented in several ways
## 4)Students, who did not go to the Museum of the History of religion, but went to the Hermitage
### Using the operator NOT IN:
```SQL
SELECT s.student_name
FROM student s
JOIN list_of_participants pl ON s.student_id = pl.student_id
JOIN excursion e ON pl.excursion_id = e.excursion_id
WHERE e.excursion_name = 'Эрмитаж'
  AND s.student_id NOT IN (
    SELECT s.student_id
    FROM student s
    JOIN list_of_participants pl ON s.student_id = pl.student_id
    JOIN excursion e ON pl.excursion_id = e.excursion_id
    WHERE e.excursion_name = 'Музей истории религии');
```
### Using the operator EXCEPT:
```SQL
SELECT s.*
FROM student AS s
JOIN list_of_participants AS pl
ON s.student_id = pl.student_id
JOIN excursion AS e 
ON pl.excursion_id = e.excursion_id
WHERE e.excursion_name = 'Эрмитаж'

EXCEPT

SELECT s.*
FROM student AS s
JOIN list_of_participants AS pl
ON s.student_id = pl.student_id
JOIN excursion AS e 
ON pl.excursion_id = e.excursion_id
WHERE e.excursion_name = 'Музей истории религии';
```
### Using the left connection:
```SQL
SELECT s.*
FROM student AS s
JOIN list_of_participants AS pl 
ON s.student_id = pl.student_id
JOIN excursion AS e 
ON pl.excursion_id = e.excursion_id
LEFT JOIN (
    SELECT pl.student_id
    FROM list_of_participants AS pl
    JOIN excursion AS e ON pl.excursion_id = e.excursion_id
    WHERE e.excursion_name = 'Музей истории религии') AS r 
	ON s.student_id = r.student_id
WHERE e.excursion_name = 'Эрмитаж' AND r.student_id IS NULL;
```
### Output
![image](https://github.com/KoWalevDV/Data-Base-2023-2024/assets/127125663/2be96be9-5d13-485f-8a8e-728b3c7c2de0)

## 5)The teacher who was responsible for the number of excursions above the average
### Using AVG:
```SQL
SELECT  t.teacher_name, t.teacher_secondname,
COUNT(DISTINCT lp.excursion_id) AS count_excursions
FROM teacher t
LEFT JOIN list_of_participants lp ON t.teacher_id = lp.teacher_id
GROUP BY t.teacher_id, t.teacher_name, t.teacher_secondname
HAVING COUNT(DISTINCT lp.excursion_id) > (
SELECT AVG(count_excursions)
FROM (
SELECT t.teacher_id,
COUNT(DISTINCT lp.excursion_id) AS count_excursions
FROM teacher t
LEFT JOIN list_of_participants lp ON t.teacher_id = lp.teacher_id
GROUP BY t.teacher_id
) AS subquery
);
```
### Output
![image](https://github.com/KoWalevDV/Data-Base-2023-2024/assets/127125663/0ad3092a-63cd-4f94-9b44-4c6069b49f6c)

## 6)The teachers responsible for the most expensive excursions
### Using MAX:
```SQL
SELECT t.teacher_name, t.teacher_secondname
FROM teacher AS t
JOIN list_of_participants  AS pl
ON t.teacher_id = pl.teacher_id
JOIN excursion AS e 
ON pl.excursion_id = e.excursion_id AND (isavailable = 'true')
WHERE e.price = (
SELECT MAX(price) FROM excursion
);
```
### Using the ALL directive:
```SQL
SELECT t.teacher_name, t.teacher_secondname
FROM teacher AS t
JOIN list_of_participants  AS pl
ON t.teacher_id = pl.teacher_id
JOIN excursion AS e 
ON pl.excursion_id = e.excursion_id AND (isavailable = 'true')
WHERE e.price >= all (
SELECT price FROM excursion 
	Where price is not NULL
);
```
### Output
![image](https://github.com/KoWalevDV/Data-Base-2023-2024/assets/127125663/4f9ebea9-8268-4a90-b4be-9170df7745af)

## 7)Excursions that all students went to
### Using 2 NOT EXISTS
```SQL
SELECT e.excursion_name
FROM excursion AS e
WHERE NOT EXISTS (
    SELECT s.student_id
    FROM student AS s
    WHERE NOT EXISTS (
        SELECT *
        FROM list_of_participants  AS pl
        WHERE pl.student_id = s.student_id
        AND pl.excursion_id = e.excursion_id
    )
);
```
### Using COUNT:
```SQL
SELECT  e.excursion_name
FROM excursion e
JOIN list_of_participants lp ON e.excursion_id = lp.excursion_id
JOIN student s ON lp.student_id = s.student_id
GROUP BY e.excursion_id, e.excursion_name
HAVING COUNT(DISTINCT s.student_id) = (SELECT COUNT(*) FROM student);
```
### Output
![image](https://github.com/KoWalevDV/Data-Base-2023-2024/assets/127125663/44dd4329-b8bc-4943-890f-3fc6e5917732)
