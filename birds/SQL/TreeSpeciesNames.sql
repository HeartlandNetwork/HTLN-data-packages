





USE HTLN_LandBirds;

SELECT  DISTINCT T.CommonName, T.ScientificName
 

FROM dbo.Plot AS L 

  JOIN dbo.VegetationSamplingEvent AS E
  ON L.ID = E.PlotID
  JOIN dbo.SubPlot AS S
  ON E.ID = S.VegetationSamplingEventID
  JOIN LU.ParkUnit AS P
  ON L.ParkUnitID = P.ID
  JOIN dbo.TreeTally AS C
  ON S.ID = C.SubplotID
  JOIN LU.DBHClass AS D
  ON C.DBHClassID = D.ID
  JOIN LU.TreeSpecies AS T
  ON C.TreeSpeciesID = T.ID

 WHERE (E.EventDateTime < '20230101')

    

/*
WHERE ((LEFT(L.LocationName,4) = 'EFMO') OR (LEFT(L.LocationName,4) = 'HEHO') 
     OR (LEFT(L.LocationName,4) = 'HOME') OR (LEFT(L.LocationName,4) = 'PIPE')) 

*/

-- (E.EventDateTime > '20220101')

ORDER BY T.ScientificName
