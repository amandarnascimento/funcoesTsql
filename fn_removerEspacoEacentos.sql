CREATE FUNCTION [dbo].[fn_Remover_Espacos_Acentuacao]
(
    @texto VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @resultado VARCHAR(MAX);
    
    -- Remove espaços no início da string
    WHILE LEFT(@texto, 1) = ' '
    BEGIN
        SET @texto = RIGHT(@texto, LEN(@texto) - 1);
    END
    
    -- Remove espaços no final da string
    WHILE RIGHT(@texto, 1) = ' '
    BEGIN
        SET @texto = LEFT(@texto, LEN(@texto) - 1);
    END
    
    -- Remove acentuação
    SET @resultado = @texto;
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'á','a'),'à','a'),'ã','a'),'í','i'),'ê','e');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'é','e'),'è','e'),'õ','o'),'ó','o'),'ô','o');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'ú','u'),'ç','c'),'Á','A'),'À','A'),'Ã','A');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'Í','I'),'É','E'),'È','E'),'Õ','O'),'Ó','O');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'Ô','O'),'Ú','U'),'Ç','C'),'Ê','E'),'Û','U');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'â','a'),'î','i'),'ô','o'),'Â','A'),'Î','I');
    
    RETURN @resultado;
END;
