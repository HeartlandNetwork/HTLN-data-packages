


USE HTLN_LandBirds;

-- run without comments


SELECT U.Name AS ParkUnit, P.LocationName AS Plot, 
    CONCAT(SUBSTRING(E.EventName, 1,4), SUBSTRING(E.EventName, 11, 16)) AS EventID, 
    E.EventDateTime, E.Temperature_C,  W.Name AS WindSpeed, W.Summary AS WindDesc, 
    R.Name AS Rain, E.Clouds_pct AS PercentCloud, N.Name AS Noise, N.Summary AS NoiseSummary, I.Name AS Interval, 
    B.ObservationNumber, S.TaxonCode AS AOUCode, S.TSN, S.ScientificName, S.Family, S.CommonName,
    B.Distance, D.Name AS DetectionType, 
    X.Name AS Sex, A.Name AS Age, B.FlockSize, B.IsPreviousPlot, B.IsFlyover, B.Comments


FROM dbo.BirdSamplingEvent AS E
  JOIN dbo.BirdObservation as B
    ON E.ID = B.BirdSamplingEventID
  JOIN LU.BirdSpecies AS S
    ON B.BirdSpeciesID = S.ID
  JOIN dbo.Plot AS P
    ON E.PlotID = P.ID
  JOIN LU.ParkUnit AS U
    ON P.ParkUnitID = U.ID
  JOIN LU.Noise AS N
    ON E.NoiseID = N.ID
  JOIN LU.Rain AS R
    ON E.RainID = R.ID
  JOIN LU.Wind AS W
	ON E.WindID = W.ID
  JOIN LU.Interval AS I
	ON B.IntervalID = I.ID
  JOIN LU.Sex AS X
    ON B.SexID = X.ID
  JOIN LU.DetectionType AS D
    ON B.DetectionTypeID = D.ID
  JOIN LU.Age AS A
    ON B.AgeID = A.ID

WHERE (E.EventDateTime < '20230101')  AND 
     -- (LEFT(P.LocationName,4) = 'HEHO') AND
    NOT (LEFT(P.LocationName,4) = 'CUVA')

-- ORDER BY P.LocationName,  E.EventName,  B.ObservationNumber;
ORDER BY E.EventDateTime
