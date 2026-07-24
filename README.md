# US-Iran War: Global Market Impact Analysis

An end-to-end analytics engineering + data analysis project examining how the 
2026 US-Iran war has affected global financial markets — sector performance, 
oil price shocks, inflation expectations, and volatility — using real market 
and macroeconomic data.

📄 **[Read the full findings memo](./findings_memo.md)**

## What this project does
- Event study measuring abnormal sector returns around major conflict escalations
- Sector divergence analysis (energy vs. defense vs. broad market)
- Oil price and inflation pass-through analysis using FRED and EIA data
- Scenario analysis: how a prolonged conflict could affect markets, grounded in 
  published IMF/OECD/Oxford Economics forecasts

## Tech stack
| Layer | Tool |
|---|---|
| Data ingestion | yfinance, FRED API, EIA API |
| Data processing | Polars |
| Local analytics engine | DuckDB |
| Transformation pipeline | dbt-core (dbt-duckdb adapter) |
| Dashboard | Plotly Dash |
| Environment/package management | uv |

## Why this stack
This project is built to mirror a modern analytics engineering workflow rather 
than a single-notebook analysis — using DuckDB + dbt for SQL-based transformations 
(the current industry standard for analytics pipelines) and Polars for fast 
in-memory processing, instead of relying solely on pandas.

## Architecture

Raw CSVs are ingested once into physical DuckDB tables (Bronze layer), then 
transformed through dbt into clean staging tables (Silver) and analysis-ready 
marts (Gold) — following a proper Medallion architecture instead of repeatedly 
reading raw files at query time.

Raw CSV (data/raw/)
↓ scripts/ingest_bronze.py
Bronze (DuckDB tables)
↓ dbt staging models
Silver (stg_market_prices, stg_macro_indicators, stg_oil_prices, stg_event_timeline)
↓ dbt marts
Gold (mart_daily_market_summary → mart_market_with_events → mart_event_study_ready)
↓ scripts/export_gold.py
data/processed/mart_event_study_ready.csv

## Data sources
- Market data: Yahoo Finance (via yfinance)
- Macro data: FRED (Federal Reserve Economic Data)
- Energy data: EIA (U.S. Energy Information Administration)

## Methodology
An event study approach measures abnormal returns for 7 market assets around 
11 verified conflict events (escalations, ceasefires, political transitions), 
comparing each event window against a 60-trading-day pre-event baseline. 
Z-scores quantify statistical significance of each reaction. Full details and 
findings are in [`findings_memo.md`](./findings_memo.md).

## Project structure
data/raw/ Raw pulled data (yfinance, FRED, EIA)
data/processed/ Final exported analysis-ready dataset
scripts/ Ingestion and export scripts (pathlib-based, run-anywhere)
dbt_project/ dbt models: staging (Silver) and marts (Gold)
notebooks/ Data collection and event study analysis
dashboard/ Interactive Dash app
findings_memo.md Written findings and scenario analysis

## Running this project
```bash
# 1. Collect raw data (optional — only if refreshing)
run notebooks/01_data_collection.ipynb

# 2. Ingest raw CSVs into Bronze tables
uv run python scripts/ingest_bronze.py

# 3. Build Silver + Gold layers
cd dbt_project/market_analysis
uv run dbt run --full-refresh --profiles-dir .

# 4. Export final dataset
cd ../..
uv run python scripts/export_gold.py

# 5. Launch dashboard
uv run python dashboard/app.py
```

## Status
🚧 In progress — dashboard build underway