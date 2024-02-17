--CREATE DATA BASE
CREATE TABLE discipline_type
(
    discipline_id integer NOT NULL,
    discipline_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT discipline_type_pkey PRIMARY KEY (discipline_id)
)

CREATE TABLE excursion_location
(
    excursion_location_id integer NOT NULL,
    excursion_location_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT excursion_location_pkey PRIMARY KEY (excursion_location_id)
)

CREATE TABLE excursions_type
(
    excursion_type_id integer NOT NULL,
    excursion_type_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT excursion_type_pkey PRIMARY KEY (excursion_type_id)
)

CREATE TABLE excursion
(
    excursion_id integer NOT NULL,
    excursion_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    
    price integer,
    excursion_type_id integer NOT NULL,
    CONSTRAINT excursion_pkey PRIMARY KEY (excursion_id),
    CONSTRAINT fk_excursion_type FOREIGN KEY (excursion_type_id)
        REFERENCES public.excursions_type (excursion_type_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

CREATE TABLE excursion_discipline
(
    excursion_discipline_id integer NOT NULL,
    excursion_id integer NOT NULL,
    discipline_id integer NOT NULL,
    CONSTRAINT excursion_discipline_pkey PRIMARY KEY (excursion_discipline_id),
    CONSTRAINT fk_discipline FOREIGN KEY (discipline_id)
        REFERENCES public.discipline_type (discipline_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_excusrion_discipline FOREIGN KEY (excursion_id)
        REFERENCES public.excursion (excursion_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

CREATE TABLE student
(
    student_id integer NOT NULL,
    student_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    student_Secondname character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT student_pkey PRIMARY KEY (student_id)
)

CREATE TABLE teacher
(
    teacher_id integer NOT NULL,
    teacher_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    teacher_Secondname character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT teacher_pkey PRIMARY KEY (teacher_id)
)

CREATE TABLE List_of_participants
(
    List_of_particip_id integer NOT NULL,
    excursion_id integer NOT NULL,
    student_id integer,
    teacher_id integer,
	isAvailable BOOLEAN,
    CONSTRAINT List_of_participants_pkey PRIMARY KEY (List_of_particip_id),
    CONSTRAINT fk_excursion FOREIGN KEY (excursion_id)
        REFERENCES public.excursion (excursion_id) MATCH SIMPLE
        ON UPDATE RESTRICT
        ON DELETE CASCADE,
    CONSTRAINT fk_student FOREIGN KEY (student_id)
        REFERENCES public.student (student_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_teacher FOREIGN KEY (teacher_id)
        REFERENCES public.teacher (teacher_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)


--FILLING DATA BASE
-------Teacher-------
Insert into teacher(teacher_id, teacher_name, teacher_secondname) VALUES(1,'Иван', 'Крыжовников');
Insert into teacher(teacher_id, teacher_name, teacher_secondname) VALUES(2,'Татьяна', 'Иванова');
Insert into teacher(teacher_id, teacher_name, teacher_secondname) VALUES(3,'Анастасия', 'Юничева');
Insert into teacher(teacher_id, teacher_name, teacher_secondname) VALUES(4,'Илья', 'Плескунин');
-------Student-------
Insert into student(student_id, student_name, student_secondname) VALUES(1,'Владимир', 'Попов');
Insert into student(student_id, student_name, student_secondname) VALUES(2,'Дарья', 'Дятлова');
Insert into student(student_id, student_name, student_secondname) VALUES(3,'Сергей', 'Мухин');
Insert into student(student_id, student_name, student_secondname) VALUES(4,'Алексей', 'Иванов');
Insert into student(student_id, student_name, student_secondname) VALUES(5,'Любовь', 'Сергеева');
Insert into student(student_id, student_name, student_secondname) VALUES(6,'Максим', 'Мухин');
Insert into student(student_id, student_name, student_secondname) VALUES(7,'Александр', 'Александров');
Insert into student(student_id, student_name, student_secondname) VALUES(8,'Евгения', 'Колокольцева');
Insert into student(student_id, student_name, student_secondname) VALUES(9,'Екатерина', 'Понамарева');
Insert into student(student_id, student_name, student_secondname) VALUES(10,'Мария', 'Фаренник');
Insert into student(student_id, student_name, student_secondname) VALUES(11,'Анна', 'Почепко');
Insert into student(student_id, student_name, student_secondname) VALUES(12,'Владимир', 'Ковалев');
Insert into student(student_id, student_name, student_secondname) VALUES(13,'Мария', 'Орлова');
Insert into student(student_id, student_name, student_secondname) VALUES(14,'Макар', 'Ерофеев');
Insert into student(student_id, student_name, student_secondname) VALUES(15,'Алексей', 'Григорьев');
Insert into student(student_id, student_name, student_secondname) VALUES(16,'Наталья', 'Колокольцева');

-------List_of_participants-------
Insert into list_of_participants(list_of_particip_id, excursion_id,teacher_id, isavailable) VALUES(1,1,3,true);
Insert into list_of_participants(list_of_particip_id, excursion_id,teacher_id, isavailable) VALUES(2,1,1,false);
Insert into list_of_participants(list_of_particip_id, excursion_id,teacher_id, isavailable) VALUES(3,4,2,true);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(4,1,1);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(5,1,2);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(6,1,3);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(7,1,4);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(8,1,5);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(9,1,6);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(10,4,7);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(11,4,8);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(12,4,9);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(13,4,10);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(14,4,11);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(15,6,12);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(16,6,13);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(17,6,14);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(18,6,15);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(19,6,16);
Insert into list_of_participants(list_of_particip_id, excursion_id,teacher_id, isavailable) VALUES(20,6,4,true);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(21,1,16);
Insert into list_of_participants(list_of_particip_id, excursion_id,teacher_id, isavailable) VALUES(22,3,3,true);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(24,5,1);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(25,5,2);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(26,5,3);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(27,5,4);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(28,5,5);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(29,5,6);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(30,5,7);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(31,5,8);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(32,5,9);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(33,5,10);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(34,5,11);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(35,5,12);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(36,5,13);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(37,5,14);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(38,5,15);
Insert into list_of_participants(list_of_particip_id, excursion_id,student_id) VALUES(39,5,16);

------- excursions_type-------
Insert into excursions_type(excursion_type_id, excursion_type_name) VALUES(1,'Образовательная');
Insert into excursions_type(excursion_type_id, excursion_type_name) VALUES(2,'Развлекательная');

-------excursion-------
Insert into excursion (excursion_id, excursion_name, price , excursion_type_id) VALUES(1,'Эрмитаж', 700, 1);
Insert into excursion (excursion_id, excursion_name, price , excursion_type_id) VALUES(2,'Кунскамера', 500, 1);
Insert into excursion (excursion_id, excursion_name, price , excursion_type_id) VALUES(3,'ТЮЗ', 450, 2);
Insert into excursion (excursion_id, excursion_name, price , excursion_type_id) VALUES(4,'Реки и каналы Санкт-Петербурга(верфь)', 800, 1);
Insert into excursion (excursion_id, excursion_name, price , excursion_type_id) VALUES(6,'Музей истории религии', 350, 1);



-------discipline_type-------
Insert into discipline_type (discipline_id, discipline_name) VALUES(1,'История России');
Insert into discipline_type (discipline_id, discipline_name) VALUES(2,'История культуры Санкт-Петербурга');
Insert into discipline_type (discipline_id, discipline_name) VALUES(3,'Изобразительное искусство');
Insert into discipline_type (discipline_id, discipline_name) VALUES(4,'Биология');
Insert into discipline_type (discipline_id, discipline_name) VALUES(5,'Музыкальное просвящение');
Insert into discipline_type (discipline_id, discipline_name) VALUES(6,'История');
Insert into discipline_type (discipline_id, discipline_name) VALUES(7,'Литература');
Insert into discipline_type (discipline_id, discipline_name) VALUES(8,'Физическая культура');
Insert into discipline_type (discipline_id, discipline_name) VALUES(9,'ОБЖ');
Insert into discipline_type (discipline_id, discipline_name) VALUES(10,'Физика');
Insert into discipline_type (discipline_id, discipline_name) VALUES(11,'Астрономия');
Insert into discipline_type (discipline_id, discipline_name) VALUES(12,'География');
Insert into discipline_type (discipline_id, discipline_name) VALUES(13,'Религия');

-------excursion_discipline-------
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(1,1,1);
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(2,1,2);
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(3,1,3);
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(4,2,4);
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(5,2,6);
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(6,3,5);
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(7,3,7);
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(8,4,2);
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(11,6,6);
Insert into excursion_discipline(excursion_discipline_id, excursion_id, discipline_id) VALUES(12,6,13);
