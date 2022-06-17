create or replace PACKAGE BODY MUSEU AS

--Regista um artista e devolve o seu id
  FUNCTION regista_artista (
    nome_in   IN artista.nome%TYPE,
    ano1_in   IN artista.ano1%TYPE,
    ano2_in   IN artista.ano2%TYPE,
    pais_in   IN artista.pais%TYPE)
    RETURN NUMBER IS 
      novo_id NUMBER :=  novo_id_artista.NEXTVAL;
    BEGIN
      INSERT INTO artista ( id, nome, ano1, ano2, pais ) 
           VALUES (novo_id, nome_in, ano1_in, ano2_in, pais_in);
  
     RETURN novo_id; 
     
    --Excepção para o mesmo nome     
    EXCEPTION 
     WHEN DUP_VAL_ON_INDEX THEN 
      RAISE_APPLICATION_ERROR(-20000, 'Nome de artista já existe.');
      
    --Excepcao ano2 > ano1
    IF (ano2_in < ano1_in) THEN
         RAISE_APPLICATION_ERROR(-20001, 'O ano de finalização tem que ser ' ||
                                         'posterior ao ano de inicialização.');
    END IF;
  END regista_artista;
  
-- ----------------------------------------------------------------------
--Regista um tipo de arte 
  PROCEDURE regista_tipo_arte(
    tipo_in   IN tipo_arte.tipo%TYPE,
    descricao_in IN tipo_arte.descricao%TYPE) AS
  BEGIN
    INSERT INTO tipo_arte (tipo, descricao)
      VALUES  (tipo_in, descricao_in);
  
  --Excepção para mesmo tipo
  EXCEPTION 
     WHEN DUP_VAL_ON_INDEX THEN 
      RAISE_APPLICATION_ERROR(-20002, 'Tipo de Arte já existe.');
  
  END regista_tipo_arte;

-- ---------------------------------------------------------------------------
-- Regista uma habilidade de um artista num tipo de arte
  PROCEDURE regista_habilidade(
    artista_in  IN  habilidade.artista%TYPE,
    arte_in     IN  habilidade.arte%TYPE,
    preferencia_in IN  habilidade.preferencia%TYPE) AS
  BEGIN
    INSERT INTO habilidade (artista, arte, preferencia)
      VALUES (artista_in, arte_in, preferencia_in);
      
   -- Exepçao artista == , habilidade /= , preferencia ==
   EXCEPTION 
     WHEN DUP_VAL_ON_INDEX THEN 
      RAISE_APPLICATION_ERROR(-20003, 'O artista já é dotado dessa habilidade' || 
                                'e/ou com esse nível de preferencia.');
   -- Exepcções 1 < prefrencia < 7 
     IF (preferencia_in NOT BETWEEN 1 AND 7) THEN
      RAISE_APPLICATION_ERROR (-20004, 'O nível de preferência ten que ser ' ||
                                'entre 1 e 7.');
    END IF;
  END regista_habilidade;

-- ---------------------------------------------------------------------------
-- Regista uma obra de arte e devolve o sei Id
  FUNCTION  regista_obra_arte(
    titulo_in   IN obra_arte.titulo%TYPE,
    ano_in      IN obra_arte.ano%TYPE) 
    RETURN NUMBER IS
      nova_obra NUMBER := novo_obra_id.NEXTVAL;
  BEGIN
    INSERT INTO obra_arte (id, titulo, ano)
      VALUES (nova_obra, titulo_in, ano_in);
  RETURN nova_obra;
 
   --Excepçao Mesmo título
  EXCEPTION 
     WHEN DUP_VAL_ON_INDEX THEN 
      RAISE_APPLICATION_ERROR(-20005, 'Esta obra de arte já existe.');
   --Excepção 1500 <ano < 2100
   IF (ano_in NOT BETWEEN 1500 AND 2100) THEN
      RAISE_APPLICATION_ERROR (-20006, 'O ano tem de ser entre 1500 e 2100.');
    END IF;      
  END regista_obra_arte;

-- ---------------------------------------------------------------------------
-- Regista a autoria de uma obra de arte (atibui um artista)
  PROCEDURE regista_autoria(
    obra_in     IN autoria.obra%TYPE,
    artista_in  IN autoria.artista%TYPE,
    arte_in     IN autoria.arte%TYPE) AS
  BEGIN
    INSERT INTO autoria (obra, artista, arte)
      VALUES (obra_in, artista_in, arte_in);
   
   -- Excepção obra==, artista /=
   EXCEPTION 
     WHEN DUP_VAL_ON_INDEX THEN 
      RAISE_APPLICATION_ERROR(-20007, 'Essa obra de arte já foi realizada' || 
                                     'por outro artista');
   --Excepção artista nao habilitado ao tipo de arte
     WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR (-20008, 'Artista não está habilitado a este tipo de arte ');
   
  END regista_autoria;

-- ---------------------------------------------------------------------------
-- Remove um artista 
  PROCEDURE remove_artista(
    id_in       IN artista.id%TYPE) AS
  BEGIN
     DELETE FROM autoria WHERE ( artista = id_in);
     DELETE FROM habilidade WHERE ( artista = id_in);
     DELETE FROM artista WHERE (id = id_in);
     
   -- Nenhuma linha foi afetada pelo comando DELETE.
   IF (SQL%ROWCOUNT = 0) THEN
       RAISE_APPLICATION_ERROR(-20009, 'Artista a remover não existe.');
   END IF;
  END remove_artista;

-- ---------------------------------------------------------------------------
-- Remove um tpo de arte
  PROCEDURE remove_tipo_arte(
    tipo_in     IN tipo_arte.tipo%TYPE) AS
  BEGIN
    DELETE FROM autoria WHERE (tipo_in = arte) ;
    DELETE FROM habilidade WHERE (tipo_in = arte) ;
    DELETE FROM tipo_arte WHERE (tipo= tipo_in);
  
   -- Nenhuma linha foi afetada pelo comando DELETE.
   IF (SQL%ROWCOUNT = 0) THEN
     RAISE_APPLICATION_ERROR(-20010, 'O tipo de arte a remover não existe.');
   END IF;
  END remove_tipo_arte;

-- ----------------------------------------------------------------------------
-- Remove uma habilidade
  PROCEDURE remove_habilidade(
    artista_in  IN  habilidade.artista%TYPE,
    arte_in     IN  habilidade.arte%TYPE) AS
  BEGIN
    DELETE FROM autoria WHERE (artista = artista_in AND arte = arte_in);
    DELETE FROM habilidade WHERE ( arte = arte_in );
   
   -- Nenhuma linha foi afetada pelo comando DELETE.
   IF (SQL%ROWCOUNT = 0) THEN
       RAISE_APPLICATION_ERROR(-20011, 'A habilidade a remover não existe.');
   END IF;
  END remove_habilidade;
  
-- ------------------------------------------------------------------------
-- Remove uma obra de arte
  PROCEDURE remove_obra_arte(
   id_in      IN obra_arte.id%TYPE) AS
  BEGIN
    DELETE FROM autoria WHERE (id_in = obra);
    DELETE FROM obra_arte WHERE (id = id_in ) ;
 
  -- Nenhuma linha foi afetada pelo comando DELETE.
  IF (SQL%ROWCOUNT = 0) THEN
       RAISE_APPLICATION_ERROR(-20012, 'A habilidade a remover não existe.');
   END IF;
  END remove_obra_arte;
  
-- ------------------------------------------------------------------------
--Remove uma autoria 
  PROCEDURE remove_autoria(
    obra_in     IN autoria.obra%TYPE,
    artista_in  IN autoria.artista%TYPE,
    arte_in     IN autoria.arte%TYPE) AS
  BEGIN
   DELETE FROM autoria WHERE (obra_in = obra AND artista_in = artista AND arte_in = arte);
  
   -- Nenhuma linha foi afetada pelo comando DELETE.
   IF (SQL%ROWCOUNT = 0) THEN
       RAISE_APPLICATION_ERROR(-20013, 'Este artista não realizou essa obra.');
   END IF;
  END remove_autoria;

END MUSEU;

