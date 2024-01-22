


USE HTLN_LandBirds;

SELECT U.Name as ParkUnit, L.LocationName AS Plot,  S.SubPlotNumber AS SubPlot, 
E.EventDateTime AS EventDate, X.Name AS Distance, D.Name AS Height, 
C.Code AS CoverClassCode, C.MidpointValue AS CoverClassMidPoint, C.Range AS CoverClassRange

FROM dbo.Plot AS L 

  JOIN dbo.VegetationSamplingEvent AS E
  ON L.ID = E.PlotID
  JOIN LU.ParkUnit AS U
  ON L.ParkUnitID = U.ID
  JOIN dbo.SubPlot AS S
  ON E.ID = S.VegetationSamplingEventID
  JOIN dbo.HorizontalVegetationProfile AS H
  ON S.ID = H.SubplotID
  JOIN LU.DensityBoardHeightClass AS D
  ON D.ID = H.DensityBoardHeightClassID
  JOIN LU.DensityBoardCoverClass AS C
  ON C.ID = H.DensityBoardCoverClassID
  JOIN LU.DensityBoardDistanceClass AS X
  ON X.ID = H.DensityBoardDistanceClassID


  WHERE (E.EventDateTime < '20230101')

  

/*
WHERE ((LEFT(L.LocationName,4) = 'EFMO') OR (LEFT(L.LocationName,4) = 'HEHO') 
     OR (LEFT(L.LocationName,4) = 'HOME') OR (LEFT(L.LocationName,4) = 'PIPE')) 
*/
--(E.EventDateTime > '20220101')

ORDER BY Plot, SubPlot, EventDate, Height
