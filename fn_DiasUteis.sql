/*CRIA��O DA FUN��O QUE TRAZ DIAS �TEIS*/

CREATE function fn_DiasUteis (@DataInicio smalldatetime , @DataFim Datetime)
RETURNS Int AS BEGIN
-- Declara��o de vari�veis
Declare @Count Int

-- Inicia��o de vari�veis
SET @Count = 0

-- Looping que verifica o intervalo de datas para contar o n�mero de dias �teis
While @DataInicio <= @DataFim
Begin
-- Verifica se a data em quest�o � dia de semana ou fim de semana. Compara com calend�rio de 2018, uma vez que n�o temos refer�ncia de pesquisa registrada em banco de dados para o ano de 2019
If DatePart(WeekDay, @DataInicio) Not In (7,1) And @DataInicio Not In ( select  DATEADD(YEAR, 1, DIAFERIADO) from GFERIADO WHERE YEAR(DIAFERIADO) =2018 )
Select @Count = @Count + 1
Select @DataInicio = Dateadd(day,1,@DataInicio)

End
-- retorno do n�mero de dias �teis.
RETURN  @Count
END