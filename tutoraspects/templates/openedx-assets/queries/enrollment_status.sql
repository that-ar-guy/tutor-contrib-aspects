select
    fes.org,
    fes.course_key,
    fes.actor_id,
    fes.enrollment_status,
    fes.enrollment_mode,
    fes.emission_time,
    cn.course_name,
    cn.course_run
from {{ DBT_PROFILE_TARGET_DATABASE }}.fact_enrollment_status fes
left join
    {{ ASPECTS_EVENT_SINK_DATABASE }}.course_names cn
    on fes.org = cn.org
    and fes.course_key = cn.course_key
