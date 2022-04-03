SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) FROM COUNTRY, CITY
WHERE COUNTRY.Code = CITY.CountryCode
GROUP BY COUNTRY.Continent;