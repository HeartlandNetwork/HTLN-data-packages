

USE HTLN_LandBirds;

SELECT U.Name as ParkUnit, L.LocationName AS Plot,  S.SubPlotNumber AS SubPlot, 
EventDateTime AS EventDate, T.Name AS GroundCover, C.Code AS CoverClassCode,
C.MidpointValue AS CoverClassMidPoint, C.Range AS CoverClassRange
FROM dbo.Plot AS L 

  JOIN dbo.VegetationSamplingEvent AS E
  ON L.ID = E.PlotID
  JOIN LU.ParkUnit AS U
  ON L.ParkUnitID = U.ID
  JOIN dbo.SubPlot AS S
  ON E.ID = S.VegetationSamplingEventID
  JOIN dbo.GroundCover AS G
  ON S.ID = G.SubPlotID
  JOIN LU.GroundCoverType AS T
  ON T.ID = G.GroundCoverTypeID
  JOIN LU.GroundCoverClass AS C
  ON C.ID = G.GroundCoverClassID

/*WHERE ((LEFT(L.LocationName,4) = 'EFMO') OR (LEFT(L.LocationName,4) = 'HEHO') 
    OR (LEFT(L.LocationName,4) = 'HOME') OR (LEFT(L.LocationName,4) = 'PIPE')) */
    
WHERE (E.EventDateTime < '20230101')


ORDER BY Plot, SubPlot, EventDate, GroundCover