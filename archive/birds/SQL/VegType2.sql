




USE HTLN_LandBirds;

SELECT P.Name AS ParkUnit, L.LocationName AS Plot, Left(E.EventDateTime,11) AS EventDate,  T.NAME AS VegType,
  V.PlotVegetationCoverClassID AS CovClass, C.MidpointValue, C.Range

FROM dbo.Plot AS L 

  JOIN dbo.VegetationSamplingEvent AS E
  ON L.ID = E.PlotID
  JOIN LU.ParkUnit AS P
  ON L.ParkUnitID = P.ID
  JOIN dbo.PlotVegetation AS V
  ON E.ID = V.VegetationSamplingEventID 
  JOIN LU.PlotVegetationType AS T
  ON T.ID = V.PlotVegetationTypeID
  JOIN LU.PlotVegetationCoverClass AS C
  ON C.ID = V.PlotVegetationCoverClassID


WHere (E.EventDateTime < '20230101')

ORDER BY Plot, EventDate, VegType
