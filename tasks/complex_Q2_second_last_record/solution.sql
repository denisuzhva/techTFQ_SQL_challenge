select
    emp_id,
    emp_name,
    dept_name,
    salary
from
    (
        select
            *,
            max(emp_id) over (
                order by
                    emp_id desc
            ) as max_id
        from
            employee
    ) x
where
    emp_id = max_id - 1