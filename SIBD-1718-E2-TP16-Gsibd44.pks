create or replace PACKAGE MUSEU AS 

 --criar novo registo do Artista
  FUNCTION  regista_artista (
    nome_in   IN artista.nome%TYPE,
    ano1_in   IN artista.ano1%TYPE,
    ano2_in   IN artista.ano2%TYPE,
    pais_in   IN artista.pais%TYPE)
    RETURN NUMBER;
    
  -- Regista  um tipo de arte e descricao (única) 
  PROCEDURE regista_tipo_arte(
    tipo_in      IN tipo_arte.tipo%TYPE,
    descricao_in IN tipo_arte.descricao%TYPE);
    
  --Regista uma habilidade de um artista num tipo de arte
  PROCEDURE regista_habilidade(
    artista_in  IN  habilidade.artista%TYPE,
    arte_in     IN  habilidade.arte%TYPE,
    preferencia_in IN  habilidade.preferencia%TYPE);
  
  --Regista uma obra de arte com um título e o ano da sua autoria
  FUNCTION  regista_obra_arte(
    titulo_in   IN obra_arte.titulo%TYPE,
    ano_in      IN obra_arte.ano%TYPE)
  RETURN NUMBER;
    
  --Regista uma obra de arte com um título e o ano da sua autoria
  PROCEDURE regista_autoria(
    obra_in     IN autoria.obra%TYPE,
    artista_in  IN autoria.artista%TYPE,
    arte_in     IN autoria.arte%TYPE);
    
  --Remove os dados de um artista
  PROCEDURE remove_artista(
    id_in       IN artista.id%TYPE);
  
  --Remove os dados sobre um tipo de arte
  PROCEDURE remove_tipo_arte(
    tipo_in     IN tipo_arte.tipo%TYPE);
    
  -- Remove os dados sobre uma habilidade de um artista
  PROCEDURE remove_habilidade(
    artista_in  IN  habilidade.artista%TYPE,
    arte_in     IN  habilidade.arte%TYPE);

  -- Remove os dados sobre uma habilidade de um artista
  PROCEDURE remove_obra_arte(
   id_in      IN obra_arte.id%TYPE);

  -- Remove os dados da autoria
  PROCEDURE remove_autoria(
    obra_in     IN autoria.obra%TYPE,
    artista_in  IN autoria.artista%TYPE,
    arte_in     IN autoria.arte%TYPE);
   

END MUSEU;

