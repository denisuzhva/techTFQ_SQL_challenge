select
    *
from
    (
        select
            emp_id,
            emp_name,
            dept_name,
            salary,
            max(salary) over (
                partition by
                    dept_name
            ) as max_salary,
            min(salary) over (
                partition by
                    dept_name
            ) as min_salary
        from
            employee
    ) x
where
    x.salary = x.max_salary
    or x.salary = x.min_salary
order by
    x.dept_name,
    x.salary