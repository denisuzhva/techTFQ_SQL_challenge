drop function if exists LagPlusOne;
drop function if exists LagPlus(int);
drop function if exists LagPlus(int, int);
create or replace function LagPlusOne (step integer) 
    returns int as 
$$ 
declare 
    templag int;
begin
    select temperature
    into templag
    from weather;
    return templag;
end;
$$
language plpgsql;

select LagPlusOne(1)
from weather