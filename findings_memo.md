# US-Iran War: Global Market Impact Analysis
## Findings Memo

**Analysis period:** January 2024 – July 2026 (baseline) | War period: February 28, 2026 – present
**Methodology:** Event study with abnormal return analysis across 11 verified conflict events

---

## Executive Summary

The 2026 US-Iran war produced statistically significant, sector-differentiated reactions across global financial markets. Oil-linked assets (Brent crude, oil ETFs) showed the strongest and most consistent abnormal reactions, with airlines absorbing the largest negative shock due to fuel-cost exposure. Contrary to historical conflict patterns, defense stocks showed comparatively muted reactions. These findings are consistent with, and independently confirm, patterns reported by major financial institutions during the conflict.

---

## Key Findings

**1. Oil markets absorbed the most severe and repeated shocks.**
Brent crude and oil ETFs registered abnormal returns with average |z-scores| of 2.1–2.3, statistically significant in 4–5 of the 11 tracked events — more than any other asset class. The largest single reaction occurred around the March 1–2 Strait of Hormuz closure, where oil-linked assets moved approximately 30% cumulatively over a 10-day window, more than 4 standard deviations from their 60-day baseline.

**2. Airlines were the most consistently negatively affected sector.**
Despite lower average significance than oil, airlines showed a highly consistent pattern — abnormal returns of roughly -12% to -13% across three separate escalation events, directly reflecting jet fuel cost sensitivity to the oil price shocks.

**3. Defense stocks underperformed expectations.**
Historical conflict cycles typically show defense sector gains during active war. This conflict showed the opposite in the short term — defense stocks registered a below-average, occasionally negative reaction (avg abnormal return: -0.3%), suggesting the market priced in supply-chain exposure or spending uncertainty rather than a straightforward "war = defense demand" narrative.

**4. Broad market (S&P 500) reactions were comparatively mild.**
The S&P 500 showed the lowest average absolute z-score (0.95) among tracked assets, indicating the broader market absorbed shocks with less volatility than sector-specific assets — consistent with diversification cushioning sector-specific shocks at the index level.

---

## Methodology Note

This analysis uses an event study approach: for each of 11 verified conflict events (escalations, ceasefires, and political transitions), daily percentage returns for 7 market assets were compared against a 60-trading-day pre-event baseline to calculate abnormal returns and z-scores. A |z-score| > 2 was treated as a statistically meaningful reaction; values below this threshold were treated as within normal market noise. Data sources: Yahoo Finance (market prices), FRED (macroeconomic indicators), EIA (oil prices).

**Limitations:** With only 11 events, findings should be read as directional evidence rather than large-sample statistical proof. Market reactions may also reflect concurrent, unrelated news — the event study isolates timing correlation, not proven causation.

---

## Scenario Analysis: If the Conflict Persists

Independent forecasts from major institutions provide a basis for scenario planning, rather than speculation:

| Scenario | Global Growth (2026) | Key Assumption |
|---|---|---|
| Short conflict (baseline) | ~3.1% (IMF) / ~2.8% (OECD) | Oil ~$82/barrel, disruption resolves quickly |
| Medium disruption | ~2.5% (IMF) | Oil sustained ~$100/barrel |
| Prolonged disruption (into 2027) | ~2.0% (IMF) / ~1.8% (OECD) | OECD flags this as the threshold for widespread individual-economy recessions |

Oxford Economics' severe scenario modeling projects Gulf state GDP contracting over 8% in 2026, US equities declining nearly 20%, and central bank policy diverging — the ECB and Bank of England raising rates to defend inflation credibility while the Fed cuts rates in response to rising unemployment.

**Interpretation:** Based on this project's own data, the sectors most exposed to a prolonged conflict — oil-linked assets and airlines — would likely see continued, possibly intensifying abnormal volatility if disruption persists, consistent with the institutional scenarios above. This is a scenario-based interpretation grounded in published forecasts, not a prediction of a specific outcome.

---

## Data & Reproducibility

Full pipeline, event timeline, and interactive dashboard available in the accompanying repository. Built using Python (Polars), DuckDB, dbt, and Plotly Dash, following a Bronze/Silver/Gold data architecture.