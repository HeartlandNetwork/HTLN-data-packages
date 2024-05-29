


USE HTLN_LandBirds


SELECT DISTINCT S.TaxonCode AS AOUCode, S.TSN, S.CommonName, S.ScientificName,
  S.Family

FROM dbo.BirdSamplingEvent AS E
  JOIN dbo.BirdObservation as B
    ON E.ID = B.BirdSamplingEventID
  JOIN LU.BirdSpecies AS S
    ON B.BirdSpeciesID = S.ID
  JOIN dbo.Plot AS P
    ON E.PlotID = P.ID

WHERE NOT (LEFT(P.LocationName,4) = 'CUVA')

-- ORDER BY P.LocationName;