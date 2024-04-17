CREATE FUNCTION [dbo].[fn_Remover_Espacos_Acentuacao]
(
    @texto VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @resultado VARCHAR(MAX);
    
    -- Remove espa�os no in�cio da string
    WHILE LEFT(@texto, 1) = ' '
    BEGIN
        SET @texto = RIGHT(@texto, LEN(@texto) - 1);
    END
    
    -- Remove espa�os no final da string
    WHILE RIGHT(@texto, 1) = ' '
    BEGIN
        SET @texto = LEFT(@texto, LEN(@texto) - 1);
    END
    
    -- Remove acentua��o
    SET @resultado = @texto;
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'�','a'),'�','a'),'�','a'),'�','i'),'�','e');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'�','e'),'�','e'),'�','o'),'�','o'),'�','o');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'�','u'),'�','c'),'�','A'),'�','A'),'�','A');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'�','I'),'�','E'),'�','E'),'�','O'),'�','O');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'�','O'),'�','U'),'�','C'),'�','E'),'�','U');
    SET @resultado = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@resultado,'�','a'),'�','i'),'�','o'),'�','A'),'�','I');
    
    RETURN @resultado;
END;
