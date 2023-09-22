select 
    id,
    city,
    temperature,
    day
from 
    (
        select
            *,
            lead(sum, 1, 0) over (order by id) as lead1,
            lead(sum, 2, 0) over (order by id) as lead2
        from
            (
                select
                    *,
                    -sign(temperature) +
                    -sign(lag(temperature, 1, 0) 
                        over (order by id)) +
                    -sign(lag(temperature, 2, 0) 
                        over (order by id)) as sum
                from weather
            ) w_checked
    ) w_lead
where sum >= 3 
or lead1 >= 3
or lead2 >= 3