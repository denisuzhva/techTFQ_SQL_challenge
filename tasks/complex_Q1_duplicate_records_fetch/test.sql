select
    user_name,
    email
from
    users
group by
    user_name,
    email
having
    count(user_name) > 1