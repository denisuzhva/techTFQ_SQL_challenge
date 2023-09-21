select
    s2.id,
    s3.student_name as new_student_name
from
    (
        select
            s1.id,
            s1.student_name,
            coalesce(leadid, 0) * coalesce(mod(s1.id, 2), 0) + coalesce(lagid, 0) * coalesce(mod(lagid, 2), 0) + cast(floor(s1.id / maxid) as int) * s1.id as sum
        from
            (
                select
                    id,
                    student_name,
                    lag (id) over (
                        order by
                            id
                    ) as lagid,
                    lead (id) over (
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
    ) s2
    join students s3 on s3.id = s2.sum