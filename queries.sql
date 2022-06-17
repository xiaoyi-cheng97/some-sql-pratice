  -- --------------------------  SELECT  --------------------------------
  
 
--3º parte – As interrogações

 -- select nº1 : ID e nome dos artistas que são escultores ou pintores, 
  --o ano em que iniciaram actividade e o seu país de origem. 
  SELECT A.id, A.nome, A.ano1, A.pais
     FROM artista A, habilidade H
     WHERE (A.id = H.artista) 
        AND (H.arte = 'Escultura' OR H.arte = 'Pintura')
  ORDER BY A.ANO1, A.pais ASC;
  
  
  -- select nº2: ID e nome dos artistas que praticam ou dança ou arte digital, ou 
  -- sejam portuguese e tenham começado depois de 98.
 SELECT DISTINCT A.id,A.nome
     FROM artista A, habilidade H
     WHERE ((A.pais = 'Portugal')
       AND (A.ano1 > 1998))
       OR (A.id = H.artista 
       AND (H.arte = 'danca'
       OR H.arte = 'arte_digital'));
  
  -- select nº3: Títulos das obras realizadas no início do milénio  por um 
  --artista italiano com nome começado por ‘F’
  SELECT O.titulo
     FROM  obra_arte O, artista A, autoria S
     WHERE (O.ano BETWEEN 2000 AND 2010)
       AND (S.obra = O.id) 
       AND (S.artista = A.id)
       AND (A.pais = 'Itália')
       AND (A.nome LIKE 'F%');
  
  
  -- select nº4 : ID e nome dos artistas portugueses, começaram depois 74,
  -- e que  nunca realizaram obras depois de 2000
    SELECT A.id, A.nome
    FROM artista A
    WHERE (A.pais = 'Portugal')
    AND (A.ano1 > 1974)
    AND (NOT EXISTS (SELECT S.obra
                      FROM obra_arte O, autoria S
                      WHERE (S.artista = A.id)
                      AND (S.obra = O.id)
                      AND (O.ano > 2000)
                      )
        );
    
  
  
  -- select nº5 : Títulos e anos das  obras que foram feitas pelos artistas com 
  --habilidade em música,e nível de preferência superior a 3. 
  SELECT O.titulo, O.ano
     FROM obra_arte O, autoria S   
     WHERE (S.obra = O.id)
       AND (S.artista = (SELECT H.artista
                          FROM habilidade H
                          WHERE (H.arte = 'Música')
                          AND (H.preferencia > 3)
                          )
      )
  ORDER BY O.ano DESC, O.titulo ASC;
  
  
  --Falta testar todos os casos
  -- select nº6 : Número de obras de arte realizadas por cada pintor, em cada ano 
  SELECT A.id, A.nome, O.ano, COUNT (O.id)
     FROM artista A, obra_arte O, autoria S, habilidade H
     WHERE (A.id = S.artista)
     AND (O.id = S.obra)
     AND (A.id = H.artista)
     AND (H.arte = 'Pintura')
  GROUP BY O.ANO, A.id, A.nome
  ORDER BY A.nome ASC, O.ano DESC;
  
  
  -- select nº7 : ID e nome dos artistas com mais obras para cada ano
SELECT O.ano, A.id, A.nome
FROM artista A, obra_arte O LEFT JOIN autoria S
                              ON O.id = S.obra 
WHERE A.id = S.artista 
 AND o.id = s.obra
GROUP BY A.id, A.nome, O.ano
HAVING (COUNT (S.obra) >= ALL (SELECT COUNT(S1.obra)
                                FROM autoria S1, obra_arte O1
                                WHERE (O1.id = S1.obra)
                                AND (O1.ano = O.ano)
                                GROUP BY S1.artista, O1.ano))
ORDER BY O.ano;
       
  -- select nº8 : ID e nome dos artistas que realizaram menos de 2 obras distintas
SELECT A.id , A.nome
    FROM artista A LEFT JOIN autoria S
                        ON A.id = S.artista
    GROUP BY A.id, A.nome 
  HAVING ( COUNT( DISTINCT S.obra) < 2);
  
  
  -- select nº9 : Para cada país de origem, o ID e nome do artista que tem mais 
  --habilidades, dizendo qual a habilidade preferida e a menos perferida
  SELECT DISTINCT A.pais, A.id, A.nome, H.arte, H.preferencia
  FROM artista A, habilidade H, (SELECT H1.artista, 
                                        MAX(H1.preferencia) as ma, 
                                        MIN(H1.preferencia) as mi, 
                                        COUNT(H1.arte) as n_hab
                                  FROM habilidade H1
                                  GROUP BY H1.artista) P
  WHERE (A.id = H.artista)
  AND (A.id = P.artista)
  AND (P.n_hab >= ALL (SELECT COUNT(H2.arte)
                      FROM habilidade H2, artista A2
                      WHERE (H2.artista = A2.id)
                      AND (A.pais = A2.pais)
                      GROUP BY H2.artista
                      ))
  AND ((H.preferencia = P.ma) 
  OR (H.preferencia = P.mi))
  GROUP BY A.pais, A.id, A.nome, H.arte, H.preferencia
  ORDER BY A.pais, A.id;
