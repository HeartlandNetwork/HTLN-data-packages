



USE HTLN_LandBirds;


SELECT U.Name AS ParkUnit, L.LocationName AS Plot,  S.SubPlotNumber AS SubPlot, E.EventDateTime AS EventDate, T.Name AS CanopyType, C.ReadingNumber, C.DotScore 

FROM dbo.Plot AS L 

  JOIN dbo.VegetationSamplingEvent AS E
  ON L.ID = E.PlotID
  JOIN dbo.SubPlot AS S
  ON E.ID = S.VegetationSamplingEventID
  JOIN LU.ParkUnit AS U
  ON L.ParkUnitID = U.ID
  JOIN dbo.CanopyCOver AS C
  ON S.ID = C.SubPlotID
  JOIN LU.CanopyType AS T
  ON T.ID = C.CanopyTypeID

WHERE (E.EventDateTime < '20230101')

ORDER BY Plot, SubPlot, EventDate, CanopyType, ReadingNumber

