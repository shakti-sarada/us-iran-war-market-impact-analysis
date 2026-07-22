# US-Iran War: Global Market Impact Analysis

An end-to-end analytics engineering + data analysis project examining how the 
2026 US-Iran war has affected global financial markets — sector performance, 
oil price shocks, inflation expectations, and volatility — using real market 
and macroeconomic data.

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

## Data sources
- Market data: Yahoo Finance (via yfinance)
- Macro data: FRED (Federal Reserve Economic Data)
- Energy data: EIA (U.S. Energy Information Administration)

## Project structure
\`\`\`
data/raw/            Raw pulled data
data/processed/       Cleaned/transformed data (via dbt)
dbt_project/          dbt models for transformation layer
notebooks/            Exploratory analysis and event study
dashboard/            Dash app for final visualization
\`\`\`

## Status
🚧 In progress
