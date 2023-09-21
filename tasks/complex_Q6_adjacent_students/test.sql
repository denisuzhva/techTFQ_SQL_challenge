select
    s1.id,
    s1.student_name,
    coalesce(leadid, 0) * coalesce(mod(s1.id, 2), 0) + coalesce(lagid, 0) * coalesce(mod(lagid, 2), 0) as sum
from
    (
        select
            id,
            student_name,
            lag (id) over (
                order by
                    id
            ) as lagid,
            lead (id, 1, id) over (
                order by
                    id
            ) as leadid,
            max(id) over (
                order by
                    id desc
            ) as maxid
        from
            students
    ) s1