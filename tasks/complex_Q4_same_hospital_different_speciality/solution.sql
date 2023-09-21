select
    d1.name,
    d1.speciality,
    d1.hospital
from
    doctors d1
    join doctors d2 on d1.hospital = d2.hospital
    and d1.name <> d2.name