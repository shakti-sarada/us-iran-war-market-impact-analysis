select
    "Date" as date,
    sp500,
    vix,
    energy_etf,
    oil_etf,
    defense_etf,
    airlines_etf,
    staples_etf,
    gold_etf,
    tips_etf,
    dollar_index,
    ten_yr_yield
from {{ source('bronze', 'bronze_market_prices') }}