




USE HTLN_LandBirds;

SELECT U.Name as ParkUnit, L.LocationName AS Plot,  S.SubPlotNumber AS SubPlot, E.EventDateTime AS EventDate, 
  T.Name AS FoliarCover, C.Code AS CoverClassCode, C.MidpointValue AS CoverClassMidPoint, C.Range AS CoverClassRange

FROM dbo.Plot AS L 

  JOIN dbo.VegetationSamplingEvent AS E
  ON L.ID = E.PlotID
  JOIN LU.ParkUnit AS U
  ON L.ParkUnitID = U.ID
  JOIN dbo.SubPlot AS S
  ON E.ID = S.VegetationSamplingEventID
  JOIN dbo.FoliarCover AS F
  ON S.ID = F.SubPlotID
  JOIN LU.FoliarCoverType AS T
  ON T.ID = F.FoliarCoverTypeID
  JOIN LU.FoliarCoverClass AS C
  ON C.ID = F.FoliarCoverClassID


WHERE (E.EventDateTime < '20230101')


ORDER BY ParkUnit,  Plot, SubPlot, EventDate, FoliarCover
