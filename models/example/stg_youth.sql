with source as (
    select * from {{ source('raw', 'youth') }}
)

select
    youth_id,
    user_type,
    youth_name_pull as name,
    gender_pull as gender,
    training_schedule,
    venue_id
    -- Add more fields as needed (e.g., contact, payment info)
from source
