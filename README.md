# Data Cleaning and EDA In MySQL
This project involves data cleaning and exploratory data analysis (EDA) on a "layoffs" dataset. The analysis is performed using SQL to gain insights into "layoffs" trends, company performance, and industry impacts.

## Project Overview

The project includes two main components:

1. **Data Cleaning**: 
   - Identification and removal of duplicate entries
   - Standardization of data formats and correction of errors
   - Handling of NULL values
   - Removal of unnecessary columns and rows

2. **Exploratory Data Analysis (EDA)**:
   - Analysis of total layoffs by various factors including company, location, industry, and country
   - Time-based analysis of layoffs trends
   - Calculation of rolling totals for monthly layoffs
   - Ranking and aggregation of layoffs data for deeper insights
     
## Dataset

The dataset used for this analysis is `layoffs-dataset.csv`, which is sourced from Kaggle. It contains information about layoffs across various companies and industries.

## Files and Directories

- `Data Cleaning.sql`: SQL script for data cleaning tasks.
- `EDA.sql`: SQL script for exploratory data analysis tasks.
- `layoffs-dataset.csv`: The original dataset used for analysis.

## Data Cleaning Steps

1. **Check for Duplicates**:
   - Identified and removed duplicate records from the dataset.

2. **Standardize Data**:
   - Trimmed whitespace from company names.
   - Corrected and standardized industry names.
   - Reformatted date fields.

3. **Handle NULL Values**:
   - Updated NULL values in the industry column using information from other records.
   - Removed rows where both `total_laid_off` and `percentage_laid_off` were NULL.

4. **Drop Unnecessary Columns**:
   - Removed columns that were no longer needed for analysis.

## Exploratory Data Analysis (EDA) Queries

1. **Max Total Laid Off**:
   - Retrieved the maximum number of total layoffs.

2. **Max and Min Percentage Laid Off**:
   - Found the maximum and minimum percentage of layoffs.

3. **Companies with 100% Laid Off**:
   - Identified companies with 100% layoffs.

4. **Companies with Most Funds Raised**:
   - Listed companies with 100% layoffs and the highest funds raised.

5. **Companies with Biggest Single Layoff**:
   - Displayed the top 5 companies with the largest single layoffs.

6. **Companies with Most Total Laid Off**:
   - Aggregated and ranked companies by total layoffs.

7. **Laid Offs by Location**:
   - Aggregated layoffs by location and listed the top 10 locations.

8. **Total Layoffs by Country**:
   - Aggregated layoffs by country.

9. **Total Layoffs per Year**:
   - Aggregated layoffs by year.

10. **Total Layoffs by Industry**:
    - Aggregated layoffs by industry and ranked industries by total layoffs.

11. **Layoffs by Company Stage**:
    - Aggregated layoffs by company stage.

12. **Total Laid Off per Year with Company, Year, and Ranking**:
    - Computed total layoffs per company per year and ranked them.

13. **Rolling Total of Layoffs per Month**:
    - Calculated monthly totals for layoffs.

14. **Rolling Total of Layoffs per Month Using CTE**:
    - Calculated rolling totals of layoffs per month using a Common Table Expression (CTE).

## How to Run

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/yourusername/layoffs-analysis.git
   ```

2. **Access the SQL Scripts**:
   - Open `Data Cleaning.sql` and `EDA.sql` in your SQL client to review and execute the queries.

3. **Connect to the Database**:
   - Ensure you have access to the `world_layoffs` database.

4. **Run the SQL Scripts**:
   - Execute the scripts in your SQL environment to perform data cleaning and analysis.

## Resources

- **MySQL Documentation**: [MySQL Official Documentation](https://dev.mysql.com/doc/)
- **Alex the Analyst**: Helped with insights and techniques for SQL queries. Check out [Alex the Analyst's YouTube Channel](https://www.youtube.com/@AlexTheAnalyst) for more SQL tutorials and data analysis tips.

## Acknowledgments

- The dataset is sourced from Kaggle.
- Special thanks to Alex the Analyst for the valuable tutorials and insights.
