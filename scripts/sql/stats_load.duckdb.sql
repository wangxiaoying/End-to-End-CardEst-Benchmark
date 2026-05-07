-- Load the stats dataset into a DuckDB database.
-- Usage: ./build/release/duckdb dbs/stats.duckdb < scripts/sql/stats_load.duckdb.sql
COPY badges       FROM 'datasets/stats/badges.csv'      (FORMAT CSV, HEADER true);
COPY comments     FROM 'datasets/stats/comments.csv'    (FORMAT CSV, HEADER true);
COPY users        FROM 'datasets/stats/users.csv'       (FORMAT CSV, HEADER true);
COPY tags         FROM 'datasets/stats/tags.csv'        (FORMAT CSV, HEADER true);
COPY posts        FROM 'datasets/stats/posts.csv'       (FORMAT CSV, HEADER true);
COPY votes        FROM 'datasets/stats/votes.csv'       (FORMAT CSV, HEADER true);
COPY postHistory  FROM 'datasets/stats/postHistory.csv' (FORMAT CSV, HEADER true);
COPY postLinks    FROM 'datasets/stats/postLinks.csv'   (FORMAT CSV, HEADER true);
