select
    user_name as repeated_names
from
    login_details
group by
    user_name
having
    count(*) > 3