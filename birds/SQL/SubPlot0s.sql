



USE HTLN_LandBirds;

SELECT L.LocationName AS LocationID, P.Name AS PeriodID, S.SubPlotNumber
FROM dbo.SamplingPeriod AS P

  JOIN dbo.VegetationSamplingEvent AS E
  ON P.ID = E.SamplingPeriodID
  JOIN dbo.Plot AS L
  ON L.ID = E.PlotID
  JOIN dbo.SubPlot AS S
  ON  E.ID = S.VegetationSamplingEventID

  WHERE S.SubPlotNumber = 0


/*

SELECT U.Name AS ParkUnit, L.LocationName AS Plot,  S.SubPlotNumber AS SubPlot, Left(E.EventDateTime,11) AS EventDate, 
H.Name AS Height, P.Name AS Vegetation, V.VerticalProfileCount AS Count 

FROM dbo.Plot AS L 

  JOIN dbo.VegetationSamplingEvent AS E
  ON L.ID = E.PlotID
  JOIN LU.ParkUnit AS U
  ON L.ParkUnitID = U.ID
  JOIN dbo.SubPlot AS S
  ON E.ID = S.VegetationSamplingEventID
  JOIN dbo.VerticalVegetationProfile AS V
  ON S.ID = V.SubplotID
  JOIN LU.VegetationProfileClass AS P
  ON P.ID = V.VegetationProfileClassID
  JOIN LU.VegetationHeightClass AS H
  ON H.ID = V.VegetationHeightClassID


  WHERE (E.EventDateTime < '20230101')

ORDER BY Plot, SubPlot, EventDate, Height, Vegetation */