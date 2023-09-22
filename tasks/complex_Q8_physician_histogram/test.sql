select 
    pt.event_name, pt.physician_id, speciality, category
from 
    patient_treatment pt
    join event_category ec on pt.event_name = ec.event_name
    join physician_speciality ps on pt.physician_id = ps.physician_id 