"""
Bronze layer ingestion — the ONLY script in this project allowed to call
read_csv_auto(). Loads each raw CSV into a physical DuckDB table exactly once.
Uses pathlib anchored to the project root, so it works regardless of the
current working directory it's launched from.
"""

from pathlib import Path
import duckdb

# Anchor to project root regardless of where this script is run from
PROJECT_ROOT = Path(__file__).resolve().parent.parent
RAW_DIR = PROJECT_ROOT / "data" / "raw"
DB_PATH = PROJECT_ROOT / "data" / "market_analysis.duckdb"

BRONZE_TABLES = {
    "bronze_market_prices": RAW_DIR / "market_prices.csv",
    "bronze_macro_indicators": RAW_DIR / "macro_indicators.csv",
    "bronze_oil_prices": RAW_DIR / "brent_oil_prices.csv",
    "bronze_event_timeline": RAW_DIR / "event_timeline.csv",
}

def ingest():
    con = duckdb.connect(str(DB_PATH))

    for table_name, csv_path in BRONZE_TABLES.items():
        if not csv_path.exists():
            raise FileNotFoundError(f"Missing raw file: {csv_path}")

        # POSIX-style path string avoids Windows backslash escaping issues
        posix_path = csv_path.as_posix()

        con.sql(f"""
            CREATE OR REPLACE TABLE {table_name} AS
            SELECT * FROM read_csv_auto('{posix_path}')
        """)

        row_count = con.sql(f"SELECT COUNT(*) FROM {table_name}").fetchone()[0]
        print(f"✅ {table_name}: {row_count} rows loaded from {csv_path.name}")

    con.close()

if __name__ == "__main__":
    ingest()