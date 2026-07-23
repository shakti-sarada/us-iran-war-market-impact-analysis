with base as (
    select * from {{ ref('mart_market_with_events') }}
),

with_returns as (
    select
        *,
        -- Daily % change for each price series
        (sp500 / lag(sp500) over (order by date) - 1) * 100 as sp500_pct_change,
        (vix / lag(vix) over (order by date) - 1) * 100 as vix_pct_change,
        (energy_etf / lag(energy_etf) over (order by date) - 1) * 100 as energy_etf_pct_change,
        (oil_etf / lag(oil_etf) over (order by date) - 1) * 100 as oil_etf_pct_change,
        (defense_etf / lag(defense_etf) over (order by date) - 1) * 100 as defense_etf_pct_change,
        (airlines_etf / lag(airlines_etf) over (order by date) - 1) * 100 as airlines_etf_pct_change,
        (staples_etf / lag(staples_etf) over (order by date) - 1) * 100 as staples_etf_pct_change,
        (gold_etf / lag(gold_etf) over (order by date) - 1) * 100 as gold_etf_pct_change,
        (dollar_index / lag(dollar_index) over (order by date) - 1) * 100 as dollar_index_pct_change,
        (brent_price / lag(brent_price) over (order by date) - 1) * 100 as brent_price_pct_change
    from base
),

with_volatility as (
    select
        *,
        -- 20-day rolling volatility (standard deviation) of S&P 500 returns
        stddev(sp500_pct_change) over (
            order by date
            rows between 19 preceding and current row
        ) as sp500_rolling_volatility_20d,

        -- 20-day rolling volatility of oil returns
        stddev(brent_price_pct_change) over (
            order by date
            rows between 19 preceding and current row
        ) as brent_rolling_volatility_20d
    from with_returns
),

with_event_window as (
    select
        w.*,
        -- Flag: is this date within 5 days (before or after) of any event?
        case when exists (
            select 1 from {{ ref('stg_event_timeline') }} e
            where abs(date_diff('day', w.date, e.date)) <= 5
        ) then true else false end as in_event_window
    from with_volatility w
)

select * from with_event_window
order by date