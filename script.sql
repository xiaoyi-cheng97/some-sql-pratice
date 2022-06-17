-- ---------sequência auxiliares para id--------------------------

DROP  SEQUENCE novo_id_artista;
DROP  SEQUENCE novo_obra_id;


-- sequencia que define id do artista
  CREATE SEQUENCE  novo_id_artista 
         INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
-- sequencia que define id da obra de arte       
  CREATE SEQUENCE novo_obra_id 
          INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE;
  
      
-- 2ºparte - o script que demonstra o uso do pacote PL/SQL num cenário de gestão dos dados  

  --  ----------------------- Regista Artista  ---------------------------------

 VARIABLE id_1 NUMBER;
     BEGIN :id_1 := museu.regista_artista('Xiao', 2010, 2013, 'China'); END;
     /
  PRINT id_1;
  
  VARIABLE id_2 NUMBER;
     BEGIN :id_2 := museu.regista_artista('Manuel', 1994, 2002, 'Portugal');END;
     /
  PRINT id_2;
  
  VARIABLE id_3 NUMBER;
     BEGIN :id_3 := museu.regista_artista('Anastácio', 1999, 2017, 'Portugal'); END;
     /
  PRINT id_3;
  
  VARIABLE id_4 NUMBER;
     BEGIN :id_4 := museu.regista_artista('Raquel', 1997, 2000, 'Polónia'); END;
     /
  PRINT id_4;
  
   VARIABLE id_5 NUMBER;
     BEGIN :id_5 := museu.regista_artista('Fernando', 2000 , 2009, 'Itália'); END;
     /
  PRINT id_5;
  
  VARIABLE id_6 NUMBER;
     BEGIN :id_6 := museu.regista_artista('Stromea', 2003 , 2009, 'França'); END;
     /
  PRINT id_6;
  
  
  
  
  -- Excepçao MESMO NOME
  -- museu.regista_artista('Daniel', 2000 , 2009, 'Portugal'); 
  
  -- Excepçoes  1500 <ano1 && ano2 < 2100 
  -- museu.regista_artista('Dan ', 1300 , 2009, 'Portugal');
  -- museu.regista_artista('Duarte ', 1560 , 2145, 'Portugal');
  
  -- Excepçao ano2 > ano1
  -- museu.regista_artista('Duarte ', 2014 , 1560, 'Portugal');
  

  -- ----------------------- Regista tipo_arte ---------------------------------
  BEGIN 
   museu.regista_tipo_arte('Pintura', 'Abstrato');
   museu.regista_tipo_arte('Escultura', 'Bustos');
   museu.regista_tipo_arte('Fotografia', 'Black AND White');
   museu.regista_tipo_arte('origami', 'arte de dobrar papel');
   museu.regista_tipo_arte('Teatro', 'revista');
   museu.regista_tipo_arte('Música', 'Pop');
   END ; 
   /
   
   
   --Excepção MESMO TIPO
   -- museu.regista_tipo_arte('Fotografia', 'BW'); 
   
   --Excepçao mesma descriçao
   -- museu.regista_tipo_arte('F', 'Black AND White');
   
  
  -- ---------------------- Regista Habilidade ---------------------------------
  BEGIN 
   MUSEU.REGISTA_HABILIDADE( 3, 'Pintura', 5);    -- Anastácio 
   MUSEU.REGISTA_HABILIDADE( 3, 'Fotografia', 4); -- Anastacio
   MUSEU.REGISTA_HABILIDADE( 2, 'Escultura', 6);  -- Manuel
   MUSEU.REGISTA_HABILIDADE( 4, 'Escultura', 1);  -- Raquel
   MUSEU.REGISTA_HABILIDADE( 1, 'Fotografia', 7); -- Xiao 
   MUSEU.REGISTA_HABILIDADE( 1, 'Teatro', 6);     -- Xiao 
   MUSEU.REGISTA_HABILIDADE( 1, 'Pintura', 5);    -- Xiao  
   MUSEU.REGISTA_HABILIDADE( 5, 'Fotografia', 7);    -- Fernando 
   MUSEU.REGISTA_HABILIDADE( 6, 'Música', 5);    -- Stromea 
  END ; 
  /
  
  -- Excepção artista == , habilidade ==, preferencia /=
  -- MUSEU.REGISTA_HABILIDADE( 3, 'Pintura', 3);
   
  -- Exepçao artista == , habilidade /= , preferencia ==
  -- MUSEU.REGISTA_HABILIDADE( 3, 'Foto', 4); --Anastacio
  
  -- Exepcções 1 < prefrencia < 7 
  -- MUSEU.REGISTA_HABILIDADE( 3, 'maquilhagem', 9);
  
  -- Excepção tipo de arte nao existe
  -- MUSEU.REGISTA_HABILIDADE( 3, 'Mercedes', 2);  --Anastacio 
  
  
  -- ---------------------- Regista obra_arte ----------------------------------
  Variable obra1 NUMBER;
    BEGIN :obra1 := museu.regista_obra_arte('Grito',1999);   End;    
    /
    Print obra1;
    
  Variable obra2 NUMBER;
    BEGIN :obra2 := museu.regista_obra_arte('Favela',1998);   End;    
    /
    Print obra2;
    
    Variable obra3 NUMBER;
    BEGIN :obra3 := museu.regista_obra_arte('Somebody',2000);  End;    
    /
    Print obra3;
  
  Variable obra4 NUMBER;
    BEGIN :obra4 := museu.regista_obra_arte('cancro',1969);   End;    
    /
    Print obra4;
    
    Variable obra5 NUMBER;
    BEGIN :obra5 := museu.regista_obra_arte('olho',1990);  End;    
    /
    Print obra5;
        
  Variable obra6 NUMBER;
    BEGIN :obra6 := museu.regista_obra_arte('muita tinta',2016);  End;    
    /
    Print obra6;   
   
   Variable obra NUMBER;
    BEGIN :obra := museu.regista_obra_arte('espirro',2016);  End;    
    /
    Print obra;
      
   
  --Excepçao Mesmo título
  -- museu.regista_obra_arte('Grito', 1893);
  
  --Excepção 1500 <ano < 2100
  -- museu.regista_obra_arte('Menina bonita', 1450);
  -- museu.regista_obra_arte('Espelho', 2300);
  
  -- ---------------------- Regista autoria  -----------------------------------
  Begin 
   museu.regista_autoria(1,3 ,'Pintura'); -- Grito, foi feito pelo anastácio
   museu.regista_autoria(3,5,'Fotografia'); -- Somebody foi feito pelo Fernando 
   museu.regista_autoria(7,3 ,'Pintura'); -- Grito, foi feito pelo anastácio
   museu.regista_autoria(6,3 ,'Pintura'); -- Muita tinta, foi feito pelo anastácio
   museu.regista_autoria(2,4 ,'Escultura');-- Raquel, esculpiu, favela
   museu.regista_autoria(4,6 ,'Música');-- Stromea tocou cancro.
  
  -- Excepção obra==, artista /=
  -- museu.regista_autoria(4,2 ,'Pintura'); -- Grito. foi feito pelo manuel
  --Excepção artista nao habilitado ao tipo de arte
  -- museu.regista_autoria(4,3 ,'Escultura');-- Anastacio nao sabe escultura
  END; 
  /
  
  -- ---------------------------------------------------------------------------

