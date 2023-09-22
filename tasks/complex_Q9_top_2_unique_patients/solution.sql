select 
    date_month,
    account_id,
    no_unique
from 
(
    select 
        account_id,
        date_month,
        --patient_id,
        count(*) as no_unique,
        row_number() over 
        (
            partition by date_month order by account_id
        ) as rnum
    from 
    (
        select distinct
            account_id,
            to_char(date, 'Month') as date_month,
            patient_id
        from 
            patient_logs
        order by
            account_id,
            patient_id
    ) mnames
    group by 
        account_id,
        date_month
    order by
        no_unique desc,
        account_id
) uniques
where 
    rnum < 3
