
CREATE TABLE dbo.Funcionarios
(
    CODFUNCIONARIO varchar(11)   NOT NULL,
    DESCRIP        varchar(255)  NOT NULL,
    CODAMBIK       varchar(1)    NOT NULL,
    FECDES         datetime2(3) NOT NULL,
    FECFIN         datetime2(3) NULL,
    FECMOD         datetime2(3) NULL,
    CODDEJ         varchar(4)    NULL,
    CODPLAZAFD     varchar(9)    NULL,
    CONSTRAINT Funcionarios$Funcionarios_PK
    PRIMARY KEY CLUSTERED (CODFUNCIONARIO)
)
go
IF OBJECT_ID('dbo.Funcionarios') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.Funcionarios >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.Funcionarios >>>'
go
CREATE TABLE dbo.Permisos
(
    CODDEJ         varchar(4)    NOT NULL,
    IDUSU          varchar(25)   NOT NULL,
    CODCUERPO      varchar(2)    NOT NULL,
    CODCARGO       varchar(9)    NOT NULL,
    CODTITULO      varchar(9)    NULL,
    CODPLAZA       varchar(1)    NULL,
    FECDES         datetime2(3) NOT NULL,
    FECFIN         datetime2(3) NULL,
    CODFUNCIONARIO varchar(11)   NULL,
    PASWD          varchar(20)   NULL,
    FECPASW        datetime2(3) NULL,
    FECCONEX       datetime2(3) NULL,
    PROGRAMA       varchar(15)   NULL,
    INICIALES      varchar(3)    NULL,
    CODSECCION     varchar(25)   NULL,
    CODPROAPOYO    varchar(4)    NULL,
    CONSTRAINT Permisos$Permisos_PK
    PRIMARY KEY CLUSTERED (CODDEJ,IDUSU,FECDES)
)
go
IF OBJECT_ID('dbo.Permisos') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.Permisos >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.Permisos >>>'
go
CREATE TABLE dbo.Usuarios
(
    IDUSU         varchar(25)      NOT NULL,
    NOMBRE        varchar(50)      NOT NULL,
    APE1          varchar(50)      NOT NULL,
    APE2          varchar(50)      NULL,
    CODTIPIDE     varchar(1)       NULL,
    NUMUSU        varchar(11)      NULL,
    EMAIL         varchar(50)      NULL,
    CODIGO_DEDO_1 smallint        NULL,
    CODIGO_DEDO_2 smallint        NULL,
    HUELLA_1      image           NULL,
    HUELLA_2      image           NULL,
    PLANTILLA_1   varbinary(1024) NULL,
    PLANTILLA_2   varbinary(1024) NULL,
    FIRMA         image           NULL,
    CODSEX        varchar(1)       NULL,
    CODPLAZA      varchar(21)      NULL,
    CONSTRAINT Usuarios$Usuarios_PK
    PRIMARY KEY NONCLUSTERED (IDUSU)
)
go
IF OBJECT_ID('dbo.Usuarios') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.Usuarios >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.Usuarios >>>'
go
