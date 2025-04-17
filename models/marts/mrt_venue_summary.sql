with participants as (
    select * from {{ ref('mrt_participant_overview') }}
),

grouped as (
    select
        county,
        ward,
        venue_name,
        count(*) as total_participants,
        avg(attendance_rate) as avg_attendance_rate,
        sum(case when potential_dropout then 1 else 0 end) * 100.0 / count(*) as dropout_rate_percent
    from participants
    group by county, ward, venue_name
)

select * from grouped
