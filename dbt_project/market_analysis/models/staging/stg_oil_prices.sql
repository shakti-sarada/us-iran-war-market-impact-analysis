select
    period::date as date,
    value as brent_price
from {{ source('bronze', 'bronze_oil_prices') }}