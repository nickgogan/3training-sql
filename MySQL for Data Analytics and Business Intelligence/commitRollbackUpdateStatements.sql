-- ROLLBACK only affects the last COMMIT.
use employees;

select * from departments;
create table departments_dup
(
	dept_no char(4) not null primary key,
    dept_name char(255) not null
)
select * from departments;
select * from departments_dup;

commit; 

select * from departments_dup order by dept_no desc;
update departments_dup
set dept_no = 'd011', dept_name = 'Quality Control';

rollback;
commit;