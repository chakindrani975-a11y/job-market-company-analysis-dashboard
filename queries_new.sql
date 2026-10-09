use company_data_analysis;
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'E:/company_data_analysis/cleaned_postings_mysql.csv'
INTO TABLE cleaned_postings
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    job_id,
    company_name,
    title,
    description,
    max_salary,
    pay_period,
    location,
    company_id,
    views,
    med_salary,
    min_salary,
    formatted_work_type,
    applies,
    original_listed_time,
    remote_allowed,
    job_posting_url,
    application_url,
    application_type,
    expiry,
    closed_time,
    formatted_experience_level,
    skills_desc,
    listed_time,
    posting_domain,
    sponsored,
    work_type,
    currency,
    compensation_type,
    normalized_salary,
    zip_code,
    fips,
    posted_date,
    posted_year,
    posted_month,
    posted_month_name,
    remote_status,
    salary_available,
    salary_estimate,
    application_rate
);
SHOW VARIABLES LIKE 'local_infile';
TRUNCATE TABLE cleaned_postings;
SELECT VERSION();
LOAD DATA LOCAL INFILE 'E:/company_data_analysis/cleaned_postings_mysql.csv'
INTO TABLE cleaned_postings
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'E:/company_data_analysis/cleaned_postings_mysql.csv'
INTO TABLE cleaned_postings
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    job_id,
    company_name,
    title,
    description,
    max_salary,
    pay_period,
    location,
    company_id,
    views,
    med_salary,
    min_salary,
    formatted_work_type,
    applies,
    original_listed_time,
    remote_allowed,
    job_posting_url,
    application_url,
    application_type,
    expiry,
    closed_time,
    formatted_experience_level,
    skills_desc,
    listed_time,
    posting_domain,
    sponsored,
    work_type,
    currency,
    compensation_type,
    normalized_salary,
    zip_code,
    fips,
    posted_date,
    posted_year,
    posted_month,
    posted_month_name,
    remote_status,
    salary_available,
    salary_estimate,
    application_rate
);
SELECT COUNT(*) AS total_rows
FROM cleaned_postings;
SELECT *
FROM cleaned_postings
LIMIT 100;
SELECT
    COUNT(*) AS total_rows,
    SUM(job_id IS NULL) AS job_id_nulls,
    SUM(company_name IS NULL) AS company_name_nulls,
    SUM(title IS NULL) AS title_nulls,
    SUM(description IS NULL) AS description_nulls,
    SUM(max_salary IS NULL) AS max_salary_nulls,
    SUM(med_salary IS NULL) AS med_salary_nulls,
    SUM(min_salary IS NULL) AS min_salary_nulls,
    SUM(company_id IS NULL) AS company_id_nulls,
    SUM(views IS NULL) AS views_nulls,
    SUM(applies IS NULL) AS applies_nulls,
    SUM(remote_allowed IS NULL) AS remote_allowed_nulls,
    SUM(application_url IS NULL) AS application_url_nulls,
    SUM(skills_desc IS NULL) AS skills_desc_nulls,
    SUM(salary_estimate IS NULL) AS salary_estimate_nulls,
    SUM(application_rate IS NULL) AS application_rate_nulls
FROM cleaned_postings;
SELECT
    COUNT(*) AS total_jobs,
    COUNT(DISTINCT company_id) AS total_companies,
    COUNT(DISTINCT location) AS total_locations,
    SUM(views) AS total_views,
    SUM(applies) AS total_applications,
    ROUND(AVG(application_rate), 2) AS avg_application_rate
FROM cleaned_postings;
SELECT
    formatted_work_type,
    COUNT(*) AS total_jobs
FROM cleaned_postings
GROUP BY formatted_work_type
ORDER BY total_jobs DESC;
SELECT
    formatted_experience_level,
    COUNT(*) AS total_jobs
FROM cleaned_postings
GROUP BY formatted_experience_level
ORDER BY total_jobs DESC;
SELECT
    remote_status,
    COUNT(*) AS total_jobs
FROM cleaned_postings
GROUP BY remote_status
ORDER BY total_jobs DESC;
SELECT
    location,
    COUNT(*) AS total_jobs
FROM cleaned_postings
WHERE location IS NOT NULL
GROUP BY location
ORDER BY total_jobs DESC
LIMIT 20;
SELECT
    title,
    COUNT(*) AS total_jobs
FROM cleaned_postings
WHERE title IS NOT NULL
GROUP BY title
ORDER BY total_jobs DESC
LIMIT 20;
SELECT
    COUNT(*) AS jobs_with_salary,
    ROUND(AVG(salary_estimate), 2) AS average_salary,
    ROUND(MIN(salary_estimate), 2) AS minimum_salary,
    ROUND(MAX(salary_estimate), 2) AS maximum_salary
FROM cleaned_postings
WHERE salary_estimate IS NOT NULL;
SELECT
    formatted_experience_level,
    COUNT(*) AS jobs_with_salary,
    ROUND(AVG(salary_estimate), 2) AS average_salary,
    ROUND(MIN(salary_estimate), 2) AS minimum_salary,
    ROUND(MAX(salary_estimate), 2) AS maximum_salary
FROM cleaned_postings
WHERE salary_estimate IS NOT NULL
GROUP BY formatted_experience_level
ORDER BY average_salary DESC;
SELECT
    ROUND(AVG(views), 2) AS avg_views,
    ROUND(AVG(applies), 2) AS avg_applications,
    SUM(views) AS total_views,
    SUM(applies) AS total_applications,
    ROUND(AVG(application_rate), 2) AS avg_application_rate
FROM cleaned_postings
WHERE views IS NOT NULL
  AND applies IS NOT NULL;
  SELECT
    posted_year,
    posted_month,
    posted_month_name,
    COUNT(*) AS total_jobs
FROM cleaned_postings
GROUP BY
    posted_year,
    posted_month,
    posted_month_name
ORDER BY
    posted_year,
    posted_month;
    SELECT
    application_type,
    COUNT(*) AS total_jobs
FROM cleaned_postings
GROUP BY application_type
ORDER BY total_jobs DESC;
SELECT
    sponsored,
    COUNT(*) AS total_jobs
FROM cleaned_postings
GROUP BY sponsored
ORDER BY total_jobs DESC;
SELECT
    currency,
    COUNT(*) AS total_jobs,
    COUNT(salary_estimate) AS jobs_with_salary
FROM cleaned_postings
GROUP BY currency
ORDER BY total_jobs DESC;
SELECT
    formatted_work_type,
    COUNT(salary_estimate) AS jobs_with_salary,
    ROUND(AVG(salary_estimate), 2) AS average_salary,
    ROUND(MIN(salary_estimate), 2) AS minimum_salary,
    ROUND(MAX(salary_estimate), 2) AS maximum_salary
FROM cleaned_postings
WHERE salary_estimate IS NOT NULL
GROUP BY formatted_work_type
ORDER BY average_salary DESC;
SELECT
    company_name,
    COUNT(*) AS total_jobs
FROM cleaned_postings
WHERE company_name IS NOT NULL
GROUP BY company_name
ORDER BY total_jobs DESC
LIMIT 20;
SELECT
    remote_status,
    COUNT(salary_estimate) AS jobs_with_salary,
    ROUND(AVG(salary_estimate), 2) AS average_salary,
    ROUND(MIN(salary_estimate), 2) AS minimum_salary,
    ROUND(MAX(salary_estimate), 2) AS maximum_salary
FROM cleaned_postings
WHERE salary_estimate IS NOT NULL
GROUP BY remote_status
ORDER BY average_salary DESC;
SELECT
    salary_available,
    COUNT(*) AS total_jobs,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cleaned_postings),
        2
    ) AS percentage_of_jobs
FROM cleaned_postings
GROUP BY salary_available
ORDER BY salary_available DESC;
SELECT
    formatted_work_type,
    COUNT(application_rate) AS jobs_with_rate,
    ROUND(AVG(application_rate), 2) AS average_application_rate,
    ROUND(MAX(application_rate), 2) AS highest_application_rate
FROM cleaned_postings
WHERE application_rate IS NOT NULL
GROUP BY formatted_work_type
ORDER BY average_application_rate DESC;
SELECT
    formatted_work_type,
    COUNT(*) AS total_jobs,
    ROUND(AVG(views), 2) AS average_views,
    ROUND(AVG(applies), 2) AS average_applications,
    ROUND(AVG(application_rate), 2) AS average_application_rate
FROM cleaned_postings
GROUP BY formatted_work_type
ORDER BY average_views DESC;
SELECT
    title,
    COUNT(*) AS total_jobs,
    SUM(applies) AS total_applications,
    ROUND(AVG(application_rate), 2) AS average_application_rate
FROM cleaned_postings
WHERE applies IS NOT NULL
GROUP BY title
ORDER BY total_applications DESC
LIMIT 20;
SELECT
    formatted_experience_level,
    COUNT(application_rate) AS jobs_with_rate,
    ROUND(AVG(application_rate), 2) AS average_application_rate,
    ROUND(MAX(application_rate), 2) AS highest_application_rate
FROM cleaned_postings
WHERE application_rate IS NOT NULL
GROUP BY formatted_experience_level
ORDER BY average_application_rate DESC;
SELECT
    location,
    COUNT(*) AS total_jobs,
    SUM(applies) AS total_applications,
    ROUND(AVG(application_rate), 2) AS average_application_rate
FROM cleaned_postings
WHERE applies IS NOT NULL
GROUP BY location
ORDER BY total_applications DESC
LIMIT 20;
SELECT
    title,
    COUNT(salary_estimate) AS jobs_with_salary,
    ROUND(AVG(salary_estimate), 2) AS average_salary
FROM cleaned_postings
WHERE salary_estimate IS NOT NULL
GROUP BY title
HAVING COUNT(salary_estimate) >= 5
ORDER BY average_salary DESC
LIMIT 20;
SELECT
    posted_year,
    posted_month,
    posted_month_name,
    formatted_work_type,
    COUNT(*) AS total_jobs
FROM cleaned_postings
GROUP BY
    posted_year,
    posted_month,
    posted_month_name,
    formatted_work_type
ORDER BY
    posted_year,
    posted_month,
    total_jobs DESC;
    