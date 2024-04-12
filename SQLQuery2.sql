--Select *
--from PortfolioProject..CovidDeaths
--where continent is not null
--order by 3,4

--select *
--from PortfolioProject..CovidVaccinations
--where continent is not null
--order by 3,4

--Select Location, date, total_cases, new_cases, total_deaths, population
--from PortfolioProject..CovidDeaths
--where continent is not null
--order by 1,2

--Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--from PortfolioProject..CovidDeaths
--where location like '%Ethiopia%' and continent is not null
--order by 1,2

--Select Location, date, population, total_cases, (total_cases/population)*100 as DeathPercentage
--from PortfolioProject..CovidDeaths
----where location like '%Ethiopia%' and continent is not null
--order by 1,2

--Select Location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfection
--from PortfolioProject..CovidDeaths
----where location like '%Ethiopia%' and continent is not null
--order by 1,2

--Select Location, Population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
--from PortfolioProject..CovidDeaths
----where location like '%Ethiopia%' and continent is not null
--group by location, population
--order by PercentPopulationInfected desc

--Select Location, max(cast(Total_Deaths as int)) as TotalDeathCount
--from PortfolioProject..CovidDeaths
----where location like '%Ethiopia%'
--where continent is not null
--group by location
--order by TotalDeathCount desc

--Select location, max(cast(Total_Deaths as int)) as TotalDeathCount
--from PortfolioProject..CovidDeaths
----where location like '%Ethiopia%'
--where continent is null
--group by location
--order by TotalDeathCount desc

--Select continent, max(cast(Total_Deaths as int)) as TotalDeathCount
--from PortfolioProject..CovidDeaths
----where location like '%Ethiopia%'
--where continent is not null
--group by continent
--order by TotalDeathCount desc

--Select  sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
--From PortfolioProject..CovidDeaths
----where location like '%Ethiopia%'
--where continent is not null
----group by date
--order by 1,2

--select *
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--on dea.location = vac.location
--and dea.date = vac.date

--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
--, sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

--with PopvsVac (Continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
--as
--(
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
--, sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location,
--dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
----order by 2,3
--)
--select *, (RollingPeopleVaccinated/population)*100
--from PopvsVac


--Drop table if exists #PercentPopulationVaccinated
--Create Table #PercentPopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--Population numeric,
--new_vaccinations numeric,
--RollingPeopleVaccinated numeric
--)
--Insert into #PercentPopulationVaccinated
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
--, sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location,
--dea.date) as RollingPeopleVaccinated
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
----where dea.continent is not null
----order by 2,3
--select *, (RollingPeopleVaccinated/population)*100
--from #PercentPopulationVaccinated

--Create View PercentPopulationVaccinated2 as
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
--, sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location,
--dea.date) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
--from PortfolioProject..CovidDeaths dea
--join PortfolioProject..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
----order by 2,3
