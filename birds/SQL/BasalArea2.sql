




USE HTLN_LandBirds;

SELECT  U.Name AS ParkUnit, L.LocationName AS Plot,  S.SubPlotNumber AS SubPlot, 
  E.EventDateTime AS EventDate, T.Name AS CanopyType, B.CanopyCount

  -- Left(E.EventDateTime,11) AS EventDate

FROM dbo.Plot AS L 

  JOIN dbo.VegetationSamplingEvent AS E
  ON L.ID = E.PlotID
  JOIN LU.ParkUnit AS U
  ON L.ParkUnitID = U.ID
  JOIN dbo.SubPlot AS S
  ON E.ID = S.VegetationSamplingEventID
  JOIN dbo.BasalArea AS B
  ON S.ID = B.SubPlotID
  JOIN LU.CanopyType AS T
  ON T.ID = B.CanopyTypeID

WHERE (E.EventDateTime < '20230101')

ORDER BY  U.Name, L.LocationName,  S.SubPlotNumber, Left(E.EventDateTime,11), T.Name

