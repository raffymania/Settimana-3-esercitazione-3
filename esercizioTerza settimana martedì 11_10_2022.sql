SELECT c.NomeCantante FROM Cantante as c, Autore as a, ESECUZIONE as e WHERE c.CodiceReg = e.CodiceReg AND e.TitoloCanz = a.TitoloCanz AND c.NomeCantante LIKE 'D%';
- OPPURE -
SELECT c.NomeCantante FROM CANTANTE as c WHERE c.NomeCantante LIKE 'D%' AND c.CodiceReg = ANY(SELECT e.CodiceReg FROM ESECUZIONE as e WHERE e.TitoloCanz = ANY(SELECT a.TitoloCanz FROM AUTORE WHERE));
- 2 -
SELECT DISCO.TitoloAlbum FROM DISCO, CONTIENE, ESECUZIONE WHERE DISCO.NroSerie = CONTIENE.NrSerieDisco AND CONTIENE.CodiceReg = ESECUZIONE.CodiceReg AND ESECUZIONE.Anno IS Null;
- OPPURE: - 
SELECT DISCO.TitoloAlbum FROM DISCO WHERE DISCO.NrSerie = ANY(SELECT NroSerieDisco FROM CONTIENE WHERE CodiceReg = ANY(SELECT CodiceReg FROM ESECUZIONE WHERE Anno IS Null)); 
-3-
SELECT DISTINCT NomeCantante
FROM CANTANTE
WHERE NomeCantante NOT IN
                     (SELECT C1.NomeCantante
                      FROM CANTANTE AS C1
                      WHERE CodiceReg NOT IN
                                        (SELECT CodiceReg
                                         FROM CANTANTE AS C2
                       WHERE C2.NomeCantante <> C1.NomeCantante));
- 4 -
SELECT NomeCantante
FROM CANTANTE
WHERE NomeCantante NOT IN
                     (SELECT C1.NomeCantante
                      FROM CANTANTE AS C1 JOIN ESECUZIONE ON
                      ESECUZIONE.CodiceReg = C1.CodiceReg
                      JOIN CANTANTE AS C2 ON
                           ESECUZIONE.CodiceReg = C2.CodiceReg
                      WHERE C1.NomeCantante <> C2.NomeCantante);
- oppure -
SELECT NomeCantante
FROM CANTANTE
WHERE NomeCantante NOT IN (
    SELECT NomeCantante 
    FROM CANTANTE c, ESECUZIONE e,CANTANTE c1
    WHERE c.CodiceReg =  e.CodiceReg AND
          c.NomeCantante <> c1.NomeCantante)
