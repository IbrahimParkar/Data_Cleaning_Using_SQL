# EXPLORATORY DATA ANALYSIS

USE world_layoffs;

SELECT * 
FROM layoffs_staging2;

# MAX LAID OFF
SELECT MAX(total_laid_off)
FROM world_layoffs.layoffs_staging2;

# MAX MIN PERCENT LAID OFF
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;

# COMPANIES WITH 100% LAID OFF
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1;

# COMPANIES WITH MOST FUND RAISED
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

# COMPANIES WITH BIGGEST SINGLE LAID OFF
SELECT company, total_laid_off
FROM world_layoffs.layoffs_staging
ORDER BY 2 DESC
LIMIT 5;

# COMPANIES WITH MOST LAID OFFS
SELECT company, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

# BY LOCATION
SELECT location, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

# TOTAL LAIDOFFS IN A COUNTRY
SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

# TOTAL LAIDOFFS PER YEAR
SELECT YEAR(date), SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 ASC;

# TOTAL LAIDOFFS BY INDUSTRY
SELECT industry, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

# LAIDOFFS BY COMPANY STAGE
SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

# TOTAL LAID OFF PER YEAR WITH COMPANY, YEAR AND RANKING
WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

# ROLLING TOTAL OF LAIDOFFS PER MONTH
SELECT SUBSTRING(date,1,7) AS dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE SUBSTRING(date,1,7) IS NOT NULL
GROUP BY dates
ORDER BY dates ASC;

# ROLLING TOTAL OF LAIDOFFS PER MONTH USING CTE
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) AS dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE SUBSTRING(date,1,7) IS NOT NULL
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) AS rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;
