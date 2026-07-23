select
    m.*,
    e.event,
    e.category as event_category
from {{ ref('mart_daily_market_summary') }} m
left join {{ ref('stg_event_timeline') }} e on m.date = e.date
order by m.date