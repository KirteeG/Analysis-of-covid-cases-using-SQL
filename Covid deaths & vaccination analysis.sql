-- Total number of COVID-19 cases and deaths per continent
SELECT continent, location, SUM(total_cases) AS total_cases, SUM(total_deaths) AS total_deaths
FROM coviddeaths
GROUP BY continent, location;

-- Ratio of total cases vs total deaths 
SELECT location, date, total_cases, total_deaths, 
(total_deaths/total_cases)*100 as death_percentage
FROM coviddeaths
WHERE location like '%india%'
ORDER BY 1,2;

-- Trend in new COVID-19 cases and tests conducted per day for a India
SELECT date, new_cases, new_tests
FROM coviddeaths
WHERE location = 'India'
ORDER BY date;

-- Total number of cases vs population in INDIA
SELECT location, date, total_cases, total_deaths, population,
(total_cases/population)*100 as death_percentage_of_populuation
FROM coviddeaths
WHERE location LIKE '%india%'
ORDER BY 1,2;

-- Country with highest infection rate compared to pupulation
SELECT location, population, Max(total_cases) as highest_infection_count, 
Max((total_cases/population))*100 as population_infected
FROM coviddeaths
GROUP BY location, population
ORDER BY
population_infected DESC;

-- Country with highest death count  
SELECT location, MAX(CAST(total_deaths AS SIGNED)) AS total_death_count 
FROM coviddeaths 
WHERE continent is not null
GROUP BY location 
ORDER BY total_death_count DESC;

--  Percentage of the population that has been fully vaccinated in each location 
SELECT location, people_fully_vaccinated_per_hundred
FROM covidvaccinations
ORDER BY people_fully_vaccinated_per_hundred DESC;

-- Country with highest vaccination count  
SELECT location, MAX(CAST(total_vaccinations_per_hundred AS SIGNED)) AS total_vaccination_count 
FROM covidvaccinations 
WHERE continent is not null
GROUP BY location 
ORDER BY total_vaccination_count  DESC;

-- Correlation between the number of COVID-19 cases and the stringency index in different countries
SELECT dea.location, dea.total_cases, vac.stringency_index
FROM coviddeaths dea
JOIN covidvaccinations vac
     ON dea.location = vac.location
     AND dea.date = vac.date
ORDER BY dea.total_cases DESC;

-- Total population vs total vaccinations in each continent
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM coviddeaths dea
JOIN covidvaccinations vac
     ON dea.location = vac.location
     AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 4 DESC,5 DESC;

-- Countries with the highest number of COVID-19 cases, and their vaccination status
SELECT dea.location, dea.total_cases, vac.people_vaccinated, vac.people_fully_vaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac
     ON dea.location = vac.location
     AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY dea.total_cases DESC
LIMIT 10;



