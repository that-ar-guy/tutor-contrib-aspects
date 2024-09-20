with
    recent_activity as (
        select course_key, COUNT(DISTINCT actor_id) as active_last_7_days
        from {{DBT_PROFILE_TARGET_DATABASE}}.`navigation_events`
        where emission_time >= NOW() - INTERVAL 7 DAY
        group by course_key
    )

select fss.*, COALESCE(ra.active_last_7_days, 0) as active_within_last_7_days
from {{DBT_PROFILE_TARGET_DATABASE}}`fact_student_status` fss
left join recent_activity ra on fss.course_key = ra.course_key
