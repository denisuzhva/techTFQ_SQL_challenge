drop table if exists users;

create table
    users (
        user_id int primary key,
        user_name varchar(30) not null,
        email varchar(50)
    );

insert into
    users
values
    (1, 'Sumit', 'sumit@gmail.com'),
    (2, 'Reshma', 'reshma@gmail.com'),
    (3, 'Farhana', 'farhana@gmail.com'),
    (4, 'Robin', 'robin@gmail.com'),
    (5, 'Robin', 'robin@gmail.com');

select
    *
from
    users;