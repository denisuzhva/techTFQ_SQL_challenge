with recursive
    cte as (
        (
            select
                *
            from
                (
                    select
                        job_positions.id,
                        'Vacant' as name,
                        totalpost - temp.pos_count as diff
                    from
                        job_positions
                        inner join (
                            select distinct
                                position_id,
                                count(*) as pos_count
                            from
                                job_employees
                            group by
                                position_id
                        ) as temp on job_positions.id = temp.position_id
                ) as init_cte
        )
        union all
        (
            select
                cte.id,
                'Vacant' as name,
                cte.diff - 1
            from
                cte
            where
                cte.diff > 1
        )
    )
select
    title,
    groups,
    levels,
    payscale,
    name
from
    job_positions
    inner join (
        (
            select
                name,
                position_id,
                id as diff -- !!! careful !!!
            from
                job_employees
        )
        union all
        (
            select
                name,
                id,
                diff
            from
                cte
        )
    ) as tmp on job_positions.id = tmp.position_id
where
    tmp.diff > 0
order by
    groups