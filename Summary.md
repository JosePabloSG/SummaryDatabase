
## Consultas a base de datos

### String de conexión 

```shell
sqlcmd -UJPSG -P2710 -SJOSE-PABLO\SQLEXPRESS
```

Para salir de la terminal, usa el comando `quit`.
### Saber que base de datos hay

```sql
SELECT name FROM sys.databases
```

### Saber en que base de datos estas

```sql
SELECT DB_Name()
```
### Saber que tablas hay en una base de datos
ojo hay que estar en  la base de datos antes 

```sql
SELECT table_name FROM information_schema.tables
```

###  Saber los campos de un tabla 
```
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'Nombre de la tabla'
```

### Hacer un respaldo de la base de datos

```sql
BACKUP DATABASE [Datos] TO DISK = N'D:\SQL-Backup\datos.bkp'
```

# Comandos de `sqlcmd`

- **-U**: Especifica el nombre de usuario para la autenticación de SQL Server.
- **-P**: Especifica la contraseña para la autenticación de SQL Server.
- **-S**: Especifica el nombre del servidor y la instancia a la que se conecta.
- **-O**: Define el archivo de salida donde se guardan los resultados.
- **-I**: Activa el modo de entrada interactiva.
- **-H**-1: Configura el tamaño de los encabezados en los resultados.
- **-W**: Elimina los espacios en blanco adicionales en los resultados.
- **-Q**: Ejecuta una consulta y cierra la conexión.
- **-i**: Especifica un archivo de entrada con comandos T-SQL.

## Funciones de strings

#### Substring

**Función**: Extrae una subcadena a partir de la posición indicada (`start`) y con una longitud determinada (`length`).
```sql
SELECT substring('abcdef', 2, 2) AS Subcadena;
-- Resultado: "bc"
```

#### Right
**Función**: Devuelve una subcadena con los últimos `length` caracteres de la expresión `char_expr`.
```sql
SELECT right('abcdefg', 3) AS UltimosTresCaracteres;
-- Resultado: "efg"
```

#### Upper
**Función**: Convierte todos los caracteres de la expresión `char_expr` a mayúsculas.
```sql
SELECT upper('abcde') AS Mayusculas;
-- Resultado: "ABCDE"
```

#### Lower
**Función**: Convierte todos los caracteres de la expresión `char_expr` a minúsculas.
```sql
SELECT lower('ABCDE') AS Minusculas;
-- Resultado: "abcde"
```

#### Charindex
**Función**: Devuelve la posición inicial de la primera aparición de `expression1` dentro de `expression2`. Si no encuentra la subcadena, devuelve 0.
```sql
SELECT charindex('b', 'abcde') AS PosicionB;
-- Resultado: 2
```

#### ltrim
**Función**: Elimina los espacios en blanco al inicio de la cadena.
```sql
SELECT ltrim('   abcde') AS SinEspaciosInicio;
-- Resultado: "abcde"
```

#### Rtrim
**Función**: Elimina los espacios en blanco al final de la cadena.
```sql
SELECT rtrim('abcde   ') AS SinEspaciosFinal;
-- Resultado: "abcde"
```

#### Str
**Función**: Convierte un valor numérico en una cadena. Se puede especificar la longitud total (`length`) y el número de decimales (`decimals`).
```sql
SELECT str(456.56, 5, 1) AS NumeroFormateado;
-- Resultado: "456.6"
```

#### Soundex
**Función**: Devuelve el código SOUNDEX de una cadena. Es una función fonética que representa cómo suena una cadena en inglés. Útil para comparar palabras que suenan de manera similar.
```sql
SELECT soundex('Green') AS SoundexCode;
-- Resultado: "G650"
```

## Funciones matemáticas

#### Abs
**Función**: Devuelve el valor absoluto de un número, eliminando el signo negativo.
```sql
SELECT abs(-99) AS ValorAbsoluto;
-- Resultado: 99
```

#### Ceiling
**Función**: Redondea hacia arriba al número entero más cercano.
```sql
SELECT ceiling(123.4) AS RedondeoArriba;
-- Resultado: 124
```

#### Floor
**Función**: Redondea un número al número de decimales especificado.
```sql
SELECT round(2.456, 2) AS Redondeo;
-- Resultado: 2.46
```

### Función `CONVERT`
**Descripción**: La función `CONVERT` se utiliza para convertir datos de un tipo a otro. Esto es especialmente útil cuando necesitas realizar conversiones explícitas entre tipos de datos en SQL, como convertir valores numéricos a cadenas de texto o convertir fechas en diferentes formatos.
```sql
SELECT CONVERT(CHAR(10), 1234.56) AS ValorConvertido;
-- Resultado: "1234.56"
```

## Funciones para Fechas
#### GETDATE
**Función**: Devuelve la fecha y hora actual del sistema.
```sql
SELECT GETDATE() AS FechaActual;
-- Resultado:  (El resultado variará según la fecha y hora del sistema)
```

#### DATENAME
**Función**: Devuelve una parte específica de la fecha (por ejemplo, mes, año, día) como una cadena de texto.
```sql
SELECT DATENAME(mm, GETDATE()) AS MesActual;
-- Resultado:  (Dependiendo del mes actual)
```

#### DATEADD
**Función**: Agrega un valor específico de unidades de tiempo (días, meses, años, etc.) a una fecha.
```sql
SELECT DATEADD(dd, 2, GETDATE()) AS FechaMasDosDias;
-- Resultado: "Feb 6 1999 12:00 AM" (Dependiendo de la fecha actual)
```

## Practica 

#### Ejercicio 1

"Se desea saber cuáles son los nombres y apellidos de los usuarios que responden a los códigos de la columna CODFUNCIONARIO que se encuentran en la tabla PERMISOS. (use las tablas PERMISOS Y USUARIO)"

```sql
USE DATOSOFIS;
GO

SELECT 
    U.NOMBRE AS Nombre, 
    CONCAT(U.APE1, ' ', U.APE2) AS Apellidos
FROM Permisos P
JOIN Usuarios U ON P.IDUSU = U.IDUSU
WHERE P.CODFUNCIONARIO IS NOT NULL;
GO
```
##### Explicación 
- **Base de datos**: Cambia el contexto a la base de datos `DATOSOFIS`.
- **Selección de columnas**: Selecciona el nombre (`U.NOMBRE`) y los apellidos concatenados (`U.APE1` y `U.APE2` con un espacio entre ellos) de la tabla `Usuarios`, renombrando el resultado de los apellidos como "Apellidos".
- **Unión de tablas**: Hace un `JOIN` entre las tablas `Permisos` y `Usuarios` utilizando la columna `IDUSU` que está presente en ambas tablas.
- **Condición**: Filtra los resultados para mostrar solo aquellos registros donde la columna `CODFUNCIONARIO` en la tabla `Permisos` no sea nula.
#### Ejercicio 2

"Muestre únicamente 10 caracteres iniciales de la columna descripción y en mayúscula (tabla Funcionarios), la columna FECFIN en formato mm-dd-aa (tabla Permisos), de los usuarios que se ubican en la columna IDUSU de la tabla PERMISOS, y cuyo campo CODFUNCIONARIO no se encuentre vacío."

```sql
USE DATOSOFIS;
GO

SELECT 
    UPPER(LEFT(F.DESCRIP, 10)) AS DESCRIP_INICIAL,
    FORMAT(P.FECFIN, 'MM-dd-yy') AS FECFIN_FORMAT,
    P.IDUSU
FROM 
    Funcionarios F
JOIN 
    Permisos P ON F.CODFUNCIONARIO = P.CODFUNCIONARIO
WHERE 
    P.CODFUNCIONARIO IS NOT NULL;
GO
```
##### Explicación 
- **Contexto**: Se usa la base de datos `DATOSOFIS`.
- **Selección de columnas**:
    - **UPPER(LEFT(F.DESCRIP, 10))**: Toma los primeros 10 caracteres de la columna `DESCRIP` de la tabla `Funcionarios`, y los convierte en mayúsculas. El resultado se presenta con el alias `DESCRIP_INICIAL`.
    - **FORMAT(P.FECFIN, 'MM-dd-yy')**: Convierte la fecha `FECFIN` de la tabla `Permisos` al formato `mm-dd-aa`, y se muestra con el alias `FECFIN_FORMAT`.
    - **P.IDUSU**: Muestra el campo `IDUSU` de la tabla `Permisos`.
- **Unión de tablas**: Se hace un `JOIN` entre las tablas `Funcionarios` y `Permisos` utilizando el campo `CODFUNCIONARIO` que está presente en ambas tablas.
- **Condición**: Se filtran los registros para que sólo se muestren aquellos donde la columna `CODFUNCIONARIO` no sea nula (es decir, donde el campo `CODFUNCIONARIO` tenga un valor).
#### Ejercicio 3

"Se desea saber cuáles son los nombres y apellidos de los usuarios que no tienen códigos en la columna CODFUNCIONARIO, esto de la tabla PERMISOS."

```sql
USE DATOSOFIS;
GO

SELECT DISTINCT 
    U.NOMBRE, 
    CONCAT(U.APE1, ' ', U.APE2) AS Apellidos
FROM dbo.Usuarios U
JOIN dbo.Permisos P ON U.IDUSU = P.IDUSU
WHERE P.CODFUNCIONARIO IS NULL;
GO
```
##### Explicación 
- **Contexto**: Cambia el contexto a la base de datos `DATOSOFIS`.
- **Selección de columnas**:
    - **U.NOMBRE**: Selecciona el nombre del usuario.
    - **CONCAT(U.APE1, ' ', U.APE2)**: Une los apellidos (`APE1` y `APE2`) en una sola columna llamada "Apellidos", separados por un espacio.
- **Unión de tablas**: Realiza un `JOIN` entre las tablas `Usuarios` y `Permisos` utilizando el campo `IDUSU` que existe en ambas tablas.
- **Condición**: Filtra los resultados para mostrar únicamente los registros donde el campo `CODFUNCIONARIO` es nulo.
- **DISTINCT**: Se utiliza `DISTINCT` para eliminar los duplicados, asegurando que si un mismo `CODFUNCIONARIO` tiene más de un registro, solo aparezca una vez en los resultados.
#### Ejercicio 4

"Se desea saber cuáles son los códigos de usuarios (IDUSU), de los funcionarios que se encuentran en la tabla FUNCIONARIOS y que tiene en la columna fecha, un valor NULL."

```sql
USE DATOSOFIS;
GO

SELECT P.IDUSU AS Codigo_IDUSU
FROM dbo.Permisos P
JOIN dbo.Funcionarios F ON P.CODFUNCIONARIO = F.CODFUNCIONARIO
WHERE F.FECFIN IS NULL;
GO
```
##### Explicación:
1. **Contexto**: La consulta utiliza la base de datos `DATOSOFIS`.
2. **Selección de columna**: Selecciona el campo `IDUSU` de la tabla `Permisos`, que corresponde al código de los usuarios.
3. **Unión de tablas**: Realiza un `JOIN` entre la tabla `Permisos` y la tabla `Funcionarios` utilizando la columna `CODFUNCIONARIO`, que está presente en ambas tablas.
4. **Condición**: Filtra los resultados para mostrar solo aquellos registros donde la columna `FECFIN` en la tabla `Funcionarios` es `NULL`.
#### Ejercicio 5
"Se desea saber si la usuario Carmen Cerdas Cisneros, se encuentra activa en la tabla PERMISOS y cuál es su código registrado en la tabla FUNCIONARIOS."
```sql
USE DATOSOFIS;
GO

SELECT DISTINCT 
    p.IDUSU AS UsuarioID, 
    f.CODFUNCIONARIO AS CodigoFuncionario,
    p.FECFIN AS FechaFinPermiso,
    CASE 
        WHEN p.FECFIN IS NULL OR p.FECFIN > GETDATE() THEN 'Activo'
        ELSE 'Inactivo'
    END AS EstadoPermiso
FROM 
    dbo.Permisos p
JOIN 
    dbo.Funcionarios f ON p.CODFUNCIONARIO = f.CODFUNCIONARIO
JOIN 
    dbo.Usuarios u ON p.IDUSU = u.IDUSU
WHERE 
    u.NOMBRE = 'Carmen' 
    AND u.APE1 = 'Cerdas' 
    AND u.APE2 = 'Cisneros';
GO
```
##### Explicación:
1. **Contexto**: Se utiliza la base de datos `DATOSOFIS`.
2. **Selección de columnas**:
    - `p.IDUSU`: Muestra el identificador de usuario de la tabla `Permisos`.
    - `f.CODFUNCIONARIO`: Muestra el código del funcionario desde la tabla `Funcionarios`.
    - `p.FECFIN`: Muestra la fecha de finalización del permiso de la tabla `Permisos`.
    - **Estado**: Se utiliza una expresión `CASE` para determinar si el usuario está "Activo" o "Inactivo" basado en la fecha de finalización del permiso (`FECFIN`):
        - Si `FECFIN` es nulo o mayor a la fecha actual (`GETDATE()`), el usuario es considerado "Activo".
        - Si `FECFIN` ya pasó, el usuario es considerado "Inactivo".
3. **Unión de tablas**: Se hace un `JOIN` entre las tablas `Permisos`, `Funcionarios` y `Usuarios` para obtener la información relevante.
4. **Condición**: Se filtran los resultados para que coincidan con el nombre completo de "Carmen Cerdas Cisneros".
5. **DISTINCT**: Se usa `DISTINCT` para asegurarse de que el resultado no tenga registros duplicados.
#### Ejercicio 6
"Se desea saber la cantidad de usuarios femeninos y masculinos que se tienen registrados, cuyo campo CODTITULO sea igual a SRDON."
```sql
USE DATOSOFIS;
GO

SELECT 
    u.CODSEX AS Genero, 
    COUNT(DISTINCT u.IDUSU) AS Cantidad
FROM 
    Permisos p
JOIN 
    Usuarios u ON p.IDUSU = u.IDUSU
WHERE 
    p.CODTITULO = 'SRDON'
GROUP BY 
    u.CODSEX;
GO
```
##### Explicación detallada:
1. **USE DATOSOFIS**: Cambia el contexto a la base de datos `DATOSOFIS`, donde se ejecutará la consulta.
2. **SELECT**:
    - **u.CODSEX AS Genero**: Se selecciona el campo `CODSEX` de la tabla `Usuarios`, que indica el género del usuario. Se renombra como `Genero` para hacerlo más descriptivo en el resultado.
    - **COUNT(DISTINCT u.IDUSU) AS Cantidad**: Esta expresión cuenta el número de usuarios únicos (`DISTINCT`) en base a su identificador `IDUSU` (de la tabla `Usuarios`), evitando que se cuenten usuarios duplicados. El resultado se presenta con el alias `Cantidad`.
3. **FROM**:
    - **Permisos p**: Indica que la consulta extrae datos de la tabla `Permisos`, la cual se referencia con el alias `p`.
    - **JOIN Usuarios u ON p.IDUSU = u.IDUSU**: Realiza una unión (JOIN) entre las tablas `Permisos` y `Usuarios`, usando la columna `IDUSU` que es común a ambas tablas. Esto permite obtener información de los usuarios que tienen permisos registrados.
4. **WHERE p.CODTITULO = 'SRDON'**: Esta condición filtra los registros de la tabla `Permisos` y solo selecciona aquellos donde el campo `CODTITULO` es igual a `'SRDON'`.
5. **GROUP BY u.CODSEX**: Agrupa los resultados por el campo `CODSEX` (el género de los usuarios). De esta forma, el conteo se realiza por separado para cada género (masculino y femenino).
