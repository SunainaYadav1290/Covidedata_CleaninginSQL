/*Cleaning Data IN SQL */
/*Converting  column total_cases,total_deaths  to bigint and finding average death percentage*/
select sum(cast(total_cases as bigint)) as 'Total Cases',sum(cast(total_deaths as int)) as 'Total Deaths',(sum(cast(new_deaths as bigint))*100)/sum(new_cases) as 'Average Death Percentage'from dbo.CovidDeaths$ order by 1,2

alter table  dbo.CovidDeaths$ alter column population  bigint
/* removing null values from data*/
update  dbo.CovidDeaths$ set population = 0  where population = NULL
select population from dbo.CovidDeaths$

select sum(total_cases) as 'Total Cases',sum(cast(total_deaths as int)) as 'Total Deaths',(sum(cast(total_deaths as int))*100)/sum(population) from dbo.CovidDeaths$ where continent is not NULL group by total_cases,total_deaths

select location,sum(new_deaths) as 'TotalDeathCount' from dbo.CovidDeaths$  where continent is  NULL  and location not in ('World','International','European Union') group by location order  by TotalDeathCount desc 


select location,population,max(total_cases) as HighestInfectionCount,max((total_cases/population))*100 as PercentPopulationInfected from dbo.CovidDeaths$ group by location,population order by PercentPopulationInfected desc

select location,population , max(case when total_cases is null then 1 else total_cases end)  as HighestInfectionCount,max(cast(total_cases as float) / population)*100 AS PercentPopulationInfected from dbo.CovidDeaths$   group by location,population having max(total_cases)>100

select location,population,cast(date as date) as date , max(case when total_cases is null then 1 else total_cases end)  as HighestInfectionCount,max(cast(total_cases as float) / population)*100 AS PercentPopulationInfected from dbo.CovidDeaths$   group by location,date ,population having max(total_cases)>100