with source as (
    select * from {{ source('raw', 'milestones') }}
)

select
    youth_id,
    milestone,
    value
from source
