with source as (
    select * from {{ source('raw', 'attendance') }}
)

select
    youth_id,
    session,
    attended
from source
