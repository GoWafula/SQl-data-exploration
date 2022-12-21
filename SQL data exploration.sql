select *
from Covidproject.dbo.CovidDeaths$
where location like '%Kenya%'
order by date desc


select date,total_cases,total_deaths,population
from Covidproject..CovidDeaths$
where location like '%Kenya%'
order by date desc



select date,total_cases,total_deaths,(total_deaths/total_cases)*100 as KenyaDeathPercentage
from Covidproject..CovidDeaths$
where location like '%Kenya%'
order by date desc


select date,population,total_cases,(total_cases/population)*100 as KenyaPercentPopulationinfected
from Covidproject..CovidDeaths$
where location like '%Kenya%'
order by date desc


select location,population,max(total_cases) as HighestInfectionCount,
Max(total_deaths)as HighestDeaths,Max((total_cases/population))*100 as PopulationInfected
from Covidproject..CovidDeaths$
where continent like '%Africa%'
group by location,population
order by PopulationInfected desc


select location,population,max(cast(total_deaths as int)) as TotalDeathCount
from Covidproject..CovidDeaths$
where continent like '%Africa%'
group by location,population
order by TotalDeathCount desc



select continent,location,population,max(cast(total_deaths as int)) as TotalDeathCount,max(total_cases) as totalcasescount
from Covidproject..CovidDeaths$
where continent is not null
--where continent like '%Africa%'
group by location,population,continent
order by TotalDeathCount desc


select continent,location,SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Covidproject..CovidDeaths$
--Where location like '%Africa%'
where continent is not null 
Group By location,continent
order by total_deaths desc

--Show total population vs vaccinations for Kenya,Africa and the world
--Kenya
select dea.date,vac.new_vaccinations,dea.population,sum(convert(int,vac.new_vaccinations)) as KenyarollingPeopleVaccinated
from Covidproject..CovidDeaths$ dea
join Covidproject..CovidVaccinations$ vac
     on dea.date = vac.date

where dea.location like '%Kenya%'
group by dea.date,vac.new_vaccinations,dea.population
order by dea.date desc

--Africa
select dea.date,dea.location,dea.continent,vac.new_vaccinations,dea.population,sum(convert(int,vac.new_vaccinations)) as AfricaRollingPeopleVaccinated
from Covidproject..CovidDeaths$ dea
join Covidproject..CovidVaccinations$ vac
     on dea.date = vac.date

where dea.continent like '%Africa%'
group by dea.date,dea.location,vac.new_vaccinations,dea.population,dea.continent
order by dea.date desc

--World
select dea.date,dea.location,dea.continent,vac.new_vaccinations,dea.population,sum(convert(int,vac.new_vaccinations)) as WorldRollingPeopleVaccinated
from Covidproject..CovidDeaths$ dea
join Covidproject..CovidVaccinations$ vac
     on dea.date = vac.date

where dea.continent is not null
group by dea.date,dea.location,vac.new_vaccinations,dea.population,dea.continent
order by dea.date desc


--Use CTE to perform calculations on the world table


With PopulationvsVaccinations (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covidproject..CovidDeaths$ dea
Join Covidproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopulationvsVaccinations
order by New_Vaccinations desc

--Use a temptable to perform calculations on the above partition by query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covidproject..CovidDeaths$ dea
Join Covidproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 


Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated
order by date desc


--Create a view that you will use to perform future visualizations

CREATE VIEW PercentagePopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covidproject..CovidDeaths$ dea
Join Covidproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
