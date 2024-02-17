# 1
## Task Topic
School trips: type (entertainment /educational), disciplines to which the educational excursion is related, cost per person, list of participants, teacher responsible for conducting.
### Implemented requests:
- excursions to the shipyard (the word "shipyard" anywhere in the name)
- excursions related to biology and geography
- teachers not responsible for excursions
- students, who did not go to the Museum of the History of religion, but went to the Hermitage
- the teacher who was responsible for the number of excursions above the average
- the teachers responsible for the most expensive excursions
- Excursions that all students went to

 # 2
 ## Development of a conceptual scheme of the subject area
 ###
 ![The physical database model](https://github.com/KoWalevDV/Data-Base-2023-2024/blob/3fb3a3226f4240641f6c0bcebe4fd1ab489011fd/%D0%BB%D0%B0%D0%B11.png) 
 # 3
  
								
 ## A table describing the referential integrity:
 | **Child table**  | **Foreign key**  | **Parent table**  | **Integrity on deletion**  | **Integrity on update**  | **Justification** |
|---|---|---|---|---|---|
|  Excursion  | id_type  | Excursion_type|  RESTRICT | CASCADE  |  The foreign key refers to the primary key of the Type of excursion, which can be changed if the type of excursion is changed.The restriction provides protection against accidental or unwanted deletion or updating of records in parent tables that have links to child tables. |
| Excursion_discipline  | id_discip_type  | 	Discipline_type  | RESTRICT  | CASCADE  | The foreign key refers to the primary key of the Disciplines, which can be changed.The restriction provides protection against accidental or unwanted deletion or updating of records in parent tables that have links to child tables. |
| 	Excursion_discipline   |  id_excursion | 	Excursion  | CASCADE  |  CASCADE  | The foreign key refers to the primary key of the Excursion, which cannot be changedCascading in the event of an update or deletion ensures that changes are automatically propagated across all related records to maintain data integrity in the database. |
| 	List of participants  | id_Teacher  | Teacher  | CASCADE  |  CASCADE  | The foreign key refers to the primary key of the Teacher, which can be changed if the teacher's last name is changed.Cascading in the event of an update or deletion ensures that changes are automatically propagated across all related records to maintain data integrity in the database. |
| List of participants  | id_Student  | Student  | CASCADE  | CASCADE  | The foreign key refers to the Student's primary key, which can be changed if the Student's last name is changed.Cascading in the event of an update or deletion ensures that changes are automatically propagated across all related records to maintain data integrity in the database. |
| List of participants  | id_excursion  | Excursion  | RESTRICT  |  RESTRICT  | The foreign key refers to the primary key of the Excursion, which cannot be changed if the list of participants is changed. It should be noted that no other table depends on the "List of participants" table, and therefore the referential integrity will not be affected.A violation of referential integrity occurs when the primary key of the parent table is changed. This restriction provides protection against accidental or unwanted deletion or updating of records in parent tables that have links to child tables. |

# It's all about creating a structural part of the structural part :wink:
