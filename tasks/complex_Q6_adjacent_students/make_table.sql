drop table if exists students;

create table
    students (
        id int primary key,
        student_name varchar(50) not null
    );

insert into
    students
values
    (1, 'James'),
    (2, 'Michael'),
    (3, 'George'),
    (4, 'Stewart'),
    (5, 'Robin');

select
    *
from
    students;