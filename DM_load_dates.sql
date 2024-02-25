-- generating dates - once for DM layer:
INSERT INTO BL_DM.dim_dates (time_day, time_mm, time_year, time_quarter, full_date, weekday_number, month_name,
				weekday_name, date_mmyyyy, is_weekend, source_system, source_entity)
SELECT
	EXTRACT(DAY FROM full_date) AS time_day,
	EXTRACT(MONTH FROM full_date) AS time_mm,
	EXTRACT(YEAR FROM full_date) AS time_year,
	EXTRACT(QUARTER FROM full_date) AS time_quarter,
	full_date,
	EXTRACT(ISODOW FROM full_date) AS weekday_number,
	TO_CHAR(full_date, 'Day') AS weekday_name,
	TO_CHAR(full_date, 'Month') AS month_name,
	TO_CHAR(full_date, 'MMYYYY') AS date_mmyyyy,
	CASE WHEN EXTRACT(ISODOW FROM full_date) IN (6, 7) THEN TRUE ELSE FALSE END AS is_weekend,
	'MANUAL' AS source_system,
	'MANUAL' AS source_entity
FROM		-- generate dates for a range
    (SELECT
		generate_series(
		'2000-01-01'::DATE,
		'2030-12-31'::DATE,
		'1 day'::INTERVAL)::DATE AS full_date) AS dates;