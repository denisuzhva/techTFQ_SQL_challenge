select
    *,
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