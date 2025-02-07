# DATA CLEANING 

USE world_layoffs;

SELECT *
FROM layoffs;

# STEPS
# 1. check for duplicates and remove any
# 2. standardize data and fix errors
# 3. Look at NULL values and see what 
# 4. remove any columns and rows that are not necessary - few ways

## 1. check for duplicates and remove any

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;

WITH duplicates_cte AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY
company,location, industry,total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions
) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicates_cte
WHERE row_num > 1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY
company,location, industry,total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions
) AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

## 2. Standardizing Data 

SELECT *
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2 
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2 
SET country = TRIM(TRAILING '.' FROM country);

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
modify column `date` DATE;

## 3. Handling NULL values

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
and t2.industry IS not NULL;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
WHERE (t1.industry IS NULL or t1.industry = '')
and t2.industry IS not NULL; 


## 4. DROP unnecessary columns or rows

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
and percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;