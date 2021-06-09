# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
  SELECT
    name
  FROM
    countries
  WHERE
    gdp > (
      SELECT
        gdp
      FROM
        countries
      WHERE
        continent = 'Europe' AND gdp IS NOT NULL
      ORDER BY
        gdp DESC
        LIMIT 1
    );
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      continent, name, area
    FROM
      countries AS C1
    WHERE
      area = (
        SELECT
          MAX(area) AS largest_area
        FROM
          countries AS C2
        WHERE
          C1.continent = C2.continent
      );
  SQL

  # execute(<<-SQL)
  # SELECT
  #   continent, MAX(area) AS largest_area
  # FROM
  #   countries
  # GROUP BY
  #   continent
  # SQL

  # execute(<<-SQL)
  #   SELECT
  #     DISTINCT (countries.continent), name, area
  #   FROM
  #     countries
  #   JOIN
  #     (SELECT
  #       continent, MAX(area) AS largest_area
  #     FROM
  #       countries
  #     GROUP BY
  #       continent
  #     ) AS largest_pop
  #   ON
  #     countries.name = name
  #   WHERE
  #     name IS NOT NULL
  # SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  # execute(<<-SQL)
  # SELECT
  #   name, continent
  # FROM
  #   countries
  # WHERE
  #   population
  # SQL
end
