



USE HTLN_LandBirds;

SELECT P.Name AS ParkUnit, L.LocationName AS Plot,   H.Name AS HabitatType,
  L.Slope, S.Name AS SlopeVariability, L.Aspect, A.Name AS AspectVariability, L.InRiparianCorridor 

/* 
Plot columns to join:  LU.ParkUnit.Name, LU.HabitatType.Name, LU.SlopeVariability.Name
LU.AspectVariability

Columns used directly from Plot: Aspect, Slope and In-Riparian

*/

FROM dbo.Plot AS L 
  JOIN LU.ParkUnit AS P
  ON L.ParkUnitID = P.ID
  JOIN LU.HabitatType AS H
  ON L.HabitatTypeID = H.ID
  JOIN LU.SlopeVariability AS S
  ON L.SlopeVariabilityID = S.ID
  JOIN LU.AspectVariability AS A
  ON L.AspectVariabilityID = A.ID

WHERE NOT (LEFT(L.LocationName,4) = 'CUVA')
ORDER BY L.LocationName

