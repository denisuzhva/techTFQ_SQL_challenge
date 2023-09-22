with cte as 
(
    select 
        pt.event_name, pt.physician_id, speciality, category
    from 
        patient_treatment pt
        join event_category ec on pt.event_name = ec.event_name
        join physician_speciality ps on pt.physician_id = ps.physician_id
)

select 
    speciality,
    count(*) as speciality_count
from 
    cte c1
where not exists 
(
    select distinct
        *
    from 
        cte c2
    where category = 'Prescription'
    and c1.physician_id = c2.physician_id
)
and category = 'Procedure'
group by speciality
