CREATE FUNCTION dbo.fn_ValorPorExtenso (@Vl_Total AS NUMERIC(12, 2))
RETURNS VARCHAR(200)
AS
BEGIN
DECLARE @Number_Value AS VARCHAR(100)
, @Number_Aux AS VARCHAR(100)
, @Number_Aux_Centavos AS VARCHAR(100)
, @Number_Aux_Unidade AS VARCHAR(100)
, @Number_Aux_Dezena AS VARCHAR(100)
, @Number_Aux_Centena AS VARCHAR(100)
, @Nome_Extenso_Milhares AS VARCHAR(100)
, @Nome_Extenso_Unidades AS VARCHAR(100)
, @Nome_Extenso_Centavos AS VARCHAR(100)
, @Unidade AS VARCHAR(100)
, @Dezena AS VARCHAR(100)
, @Centena AS VARCHAR(100)
, @Grandeza AS INT
, @FimNumero AS INT

SET @Grandeza = 0
SET @FimNumero = 0
SET @Number_Value = CAST(@Vl_Total AS VARCHAR(12))

WHILE (@FimNumero < 1)
BEGIN
-- Pegando o n�mero de 3 em 3 algarismos
SET @Number_Aux = RIGHT(@Number_Value, 3)
SET @Number_Aux = RIGHT('000' + @Number_Aux, 3)
-- Definindo o nome da unidade
SET @Number_Aux_Unidade = RIGHT(@Number_Aux, 1)

SELECT @Unidade = CASE WHEN @Number_Aux_Unidade = '1' THEN 'um'
                    WHEN @Number_Aux_Unidade = '2' THEN 'dois'
                    WHEN @Number_Aux_Unidade = '3' THEN 'tr�s'
                    WHEN @Number_Aux_Unidade = '4' THEN 'quatro'
                    WHEN @Number_Aux_Unidade = '5' THEN 'cinco'
                    WHEN @Number_Aux_Unidade = '6' THEN 'seis'
                    WHEN @Number_Aux_Unidade = '7' THEN 'sete'
                    WHEN @Number_Aux_Unidade = '8' THEN 'oito'
                    WHEN @Number_Aux_Unidade = '9' THEN 'nove'
                    ELSE NULL END

-- Definindo o nome da dezena
SET @Number_Aux_Dezena = SUBSTRING(@Number_Aux, 2, 1)

SELECT @Dezena = CASE WHEN @Number_Aux_Dezena = '1' THEN 'dez'
                    WHEN @Number_Aux_Dezena = '2' THEN 'vinte'
                    WHEN @Number_Aux_Dezena = '3' THEN 'trinta'
                    WHEN @Number_Aux_Dezena = '4' THEN 'quarenta'
                    WHEN @Number_Aux_Dezena = '5' THEN 'cinquenta'
                    WHEN @Number_Aux_Dezena = '6' THEN 'sessenta'
                    WHEN @Number_Aux_Dezena = '7' THEN 'setenta'
                    WHEN @Number_Aux_Dezena = '8' THEN 'oitenta'
                    WHEN @Number_Aux_Dezena = '9' THEN 'noventa'
                    ELSE NULL END

-- Definindo o nome da centena
SET @Number_Aux_Centena = LEFT(@Number_Aux, 1)

SELECT @Centena = CASE WHEN @Number_Aux_Centena = '1' THEN 'cento'
                    WHEN @Number_Aux_Centena = '2' THEN 'duzentos'
                    WHEN @Number_Aux_Centena = '3' THEN 'trezentos'
                    WHEN @Number_Aux_Centena = '4' THEN 'quatrocentos'
                    WHEN @Number_Aux_Centena = '5' THEN 'quinhentos'
                    WHEN @Number_Aux_Centena = '6' THEN 'seiscentos'
                    WHEN @Number_Aux_Centena = '7' THEN 'setecentos'
                    WHEN @Number_Aux_Centena = '8' THEN 'oitocentos'
                    WHEN @Number_Aux_Centena = '9' THEN 'novecentos'
                    ELSE NULL END

-- Casos Especiais
IF (@Number_Aux = '100')
BEGIN
SET @Centena = 'cem'
END

IF (@Number_Aux_Dezena = '1' AND @Number_Aux_Unidade <> '0')
BEGIN
SET @Dezena = NULL

SELECT @Unidade = CASE WHEN @Number_Aux_Unidade = '1' THEN 'onze'
                    WHEN @Number_Aux_Unidade = '2' THEN 'doze'
                    WHEN @Number_Aux_Unidade = '3' THEN 'treze'
                    WHEN @Number_Aux_Unidade = '4' THEN 'quatorze'
                    ELSE NULL END
END

-- Definindo o nome da grandeza
SELECT @Nome_Extenso_Unidades = CASE @Grandeza
                                WHEN 0 THEN ''
                                WHEN 1 THEN 'mil'
                                WHEN 2 THEN 'milh�o'
                                WHEN 3 THEN 'bilh�o'
                                WHEN 4 THEN 'trilh�o'
                                WHEN 5 THEN 'quatrilh�o'
                                WHEN 6 THEN 'quintilh�o'
                                WHEN 7 THEN 'sextilh�o'
                                WHEN 8 THEN 'septilh�o'
                                WHEN 9 THEN 'octilh�o'
                                WHEN 10 THEN 'nonilh�o'
                                WHEN 11 THEN 'decilh�o'
                                ELSE NULL END

-- Concatenando o nome da grandeza
SET @Nome_Extenso_Unidades = @Nome_Extenso_Unidades + ' '

-- Concatenando o nome da grandeza com o nome da centena, dezena e unidade
SET @Nome_Extenso_Unidades = @Nome_Extenso_Unidades + @Centena + ' e ' + @Dezena + ' e ' + @Unidade

-- Incrementando a grandeza
SET @Grandeza = @Grandeza + 1

-- Verificando se � o fim do n�mero
IF (LEN(@Number_Value) <= 3)
BEGIN
SET @FimNumero = 1
END
ELSE
BEGIN
-- Retirando os 3 �ltimos algarismos
SET @Number_Value = LEFT(@Number_Value, LEN(@Number_Value) - 3)
END
END

RETURN @Nome_Extenso_Unidades
END
