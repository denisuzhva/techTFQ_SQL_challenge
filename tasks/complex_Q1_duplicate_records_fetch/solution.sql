select
    user_id,
    user_name,
    email
from
    (
        select
            *,
            row_number() over (
                partition by
                    user_name
            ) as row_number
        from
            users
    ) x
where
    row_number <> 1