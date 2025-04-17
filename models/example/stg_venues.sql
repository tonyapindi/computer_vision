with source as (
    select * from {{ source('raw', 'venues') }}
)

select
    venue_id,
    county_pull as county,
    ward,
    training_venue as venue_name
from source
