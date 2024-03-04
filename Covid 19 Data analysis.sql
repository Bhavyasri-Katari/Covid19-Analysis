/* Data Exploration and Analysis - Profolio Project */
--Date wise likelihood of dying due to covid - totalcases vs totaldeaths in india
select date,total_cases,total_deaths 
from public."CovidDeaths" where location ilike '%India' order by total_cases
-- Total % of pople died out of entire population - in india
select MAX(total_deaths)/AVG(cast(population as integer))*100 as total_percent_deaths from public."CovidDeaths" where iso_code = 'IND'
--Verify b by info seperately
select total_deaths,population from "CovidDeaths" where iso_code = 'IND' order by total_deaths
--country with highest death as % of population
select location,max(total_deaths)/avg(cast(population as bigint))*100 as percentage from "CovidDeaths" group by location order by percentage DESC
--total % of covid +ve cases in india
select max(total_cases)/avg(cast(population as bigint))*100 as percentage from "CovidDeaths" where location ilike '%India%'
--total % of covid +ve cases in world
select location,max(total_cases)/avg(cast(population as bigint))*100 as percentage from "CovidDeaths" group by location order by percentage DESC
-- continent wise +ve cases
select location,max(total_cases) as total_cases from "CovidDeaths" where continent is NULL group by location order by total_cases DESC
-- continent wise deaths
select location,max(total_deaths) as total_deaths from "CovidDeaths" where continent is NULL group by location order by total_deaths DESC
-- Daily new cases vs hospitalize vs icu patients - india
select date,new_cases,hosp_patients,icu_patients from "CovidDeaths" where location ilike '%India'
--countr wise age > 65
select deaths.date,deaths.location,vaccinations.aged_65_older from "CovidDeaths" as deaths
join "CovidVaccinations" as vaccinations
on deaths.iso_code = vaccinations.iso_code and deaths.date = vaccinations.date
--country wise total vaccinated persons
select deaths.location as country,max(vaccinations.people_fully_vaccinated) as fully_vaccinated from "CovidDeaths" as deaths
join "CovidVaccinations" as vaccinations
on deaths.iso_code = vaccinations.iso_code and deaths.date = vaccinations.date
where deaths.continent is not null 
group by country
order by fully_vaccinated