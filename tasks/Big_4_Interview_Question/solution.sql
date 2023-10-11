select 
    brand
from 
    (
        select 
            year, 
            brand, 
            sign(amount - 
            lag(amount, 1, 0) over (partition by brand order by year)) as amount_sign
        from brands
    ) x
group by brand
having count(x.amount_sign) = sum(x.amount_sign)

