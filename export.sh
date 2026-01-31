#!/usr/bin/env bash

# Connection parameters
export DB_NAME="stats_CEB"
export USER="guest"
export PASSWORD="ctu-relational"
export HOST="relational.fel.cvut.cz"

# Get list of tables
tables=$(mariadb \
	-u "$USER" \
	-p"$PASSWORD" \
	-h "$HOST" \
	-D "$DB_NAME" \
	-N \
	-e "SHOW TABLES;")

# Export each table as CSV
for table in $tables; do
	echo "Exporting $table..."

	mariadb \
		-u "$USER" \
		-p"$PASSWORD" \
		-h "$HOST" \
		-D "$DB_NAME" \
		--batch --raw \
		-e "SELECT * FROM \`$table\`;" |
		awk -F'\t' 'BEGIN { OFS="," } { 
			for (i = 1; i <= NF; i++) { 
				if ($i == "NULL") $i = "";
				printf "%s%s", $i, (i < NF ? OFS : ORS) 
			} 
		}' > "/tmp/${table}.csv"
	done
