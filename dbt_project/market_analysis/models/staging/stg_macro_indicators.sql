select
    "Date" as date,
    cpi,
    core_cpi,
    breakeven_5yr,
    breakeven_10yr,
    fed_funds_rate,
    unemployment,
    consumer_sentiment
from {{ source('bronze', 'bronze_macro_indicators') }}