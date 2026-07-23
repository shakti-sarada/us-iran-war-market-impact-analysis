from pathlib import Path
import duckdb

PROJECT_ROOT = Path(__file__).resolve().parent.parent
DB_PATH = PROJECT_ROOT / "data" / "market_analysis.duckdb"
OUTPUT_PATH = PROJECT_ROOT / "data" / "processed" / "mart_event_study_ready.csv"

OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

con = duckdb.connect(str(DB_PATH))
con.sql(f"""
    COPY mart_event_study_ready
    TO '{OUTPUT_PATH.as_posix()}'
    (HEADER, DELIMITER ',')
""")
con.close()

print(f"✅ Export complete: {OUTPUT_PATH}")