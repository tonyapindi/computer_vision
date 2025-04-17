with attendance as (
    select
        youth_id,
        count(*) as total_sessions,
        sum(case when attended then 1 else 0 end) as attended_sessions,
        round(100.0 * sum(case when attended then 1 else 0 end)::numeric / count(*), 2) as attendance_rate
    from {{ ref('stg_attendance') }}
    group by youth_id
),

milestones as (
    select
        youth_id,
        count(*) as milestone_count,
        sum(value::numeric) as total_milestone_value
    from {{ ref('stg_milestones') }}
    group by youth_id
),

youth as (
    select * from {{ ref('stg_youth') }}
),

venues as (
    select * from {{ ref('stg_venues') }}
)

select
    y.youth_id,
    y.name,
    y.gender,
    y.user_type,
    y.training_schedule,
    v.county,
    v.ward,
    v.venue_name,
    a.total_sessions,
    a.attended_sessions,
    a.attendance_rate,
    case
        when a.attendance_rate < 50 then true
        else false
    end as potential_dropout,
    m.milestone_count,
    m.total_milestone_value
from youth y
left join attendance a on y.youth_id = a.youth_id
left join milestones m on y.youth_id = m.youth_id
left join venues v on y.venue_id = v.venue_id
