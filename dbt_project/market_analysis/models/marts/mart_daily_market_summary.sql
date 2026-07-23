with market as (
    select * from {{ ref('stg_market_prices') }}
),

macro as (
    select * from {{ ref('stg_macro_indicators') }}
),

oil as (
    select
        date,
        brent_price
    from {{ ref('stg_oil_prices') }}
),

-- Get all dates present in market data (our daily backbone)
date_spine as (
    select date from market
),

joined as (
    select
        d.date,
        m.sp500,
        m.vix,
        m.energy_etf,
        m.oil_etf,
        m.defense_etf,
        m.airlines_etf,
        m.staples_etf,
        m.gold_etf,
        m.tips_etf,
        m.dollar_index,
        m.ten_yr_yield,
        o.brent_price,
        mc.cpi,
        mc.core_cpi,
        mc.breakeven_5yr,
        mc.breakeven_10yr,
        mc.fed_funds_rate,
        mc.unemployment,
        mc.consumer_sentiment
    from date_spine d
    left join market m on d.date = m.date
    left join oil o on d.date = o.date
    left join macro mc on d.date = mc.date
),

-- Forward-fill: carry the last known value forward for every null
filled as (
    select
        date,
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
        ten_yr_yield,
        last_value(brent_price ignore nulls) over (order by date) as brent_price,
        last_value(cpi ignore nulls) over (order by date) as cpi,
        last_value(core_cpi ignore nulls) over (order by date) as core_cpi,
        last_value(breakeven_5yr ignore nulls) over (order by date) as breakeven_5yr,
        last_value(breakeven_10yr ignore nulls) over (order by date) as breakeven_10yr,
        last_value(fed_funds_rate ignore nulls) over (order by date) as fed_funds_rate,
        last_value(unemployment ignore nulls) over (order by date) as unemployment,
        last_value(consumer_sentiment ignore nulls) over (order by date) as consumer_sentiment
    from joined
)

select * from filled
order by date