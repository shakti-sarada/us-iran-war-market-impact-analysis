select
    date::date as date,
    event,
    category
from {{ source('bronze', 'bronze_event_timeline') }}