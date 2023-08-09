-- Generado por Oracle SQL Developer Data Modeler 21.1.0.092.1221
--   en:        2021-06-27 15:08:46 CLT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE antecedentes_postulacion (
    id_ant_post     NUMBER(3) NOT NULL,
    dura_peri_estu  NUMBER(3) NOT NULL,
    doc_invest      VARCHAR2(30) NOT NULL,
    retribucion     VARCHAR2(30) NOT NULL,
    id_inst_aca     NUMBER(3) NOT NULL,
    id_postul       NUMBER(3) NOT NULL
);

CREATE UNIQUE INDEX antpost__idx ON
    antecedentes_postulacion (
        id_ant_post
    ASC );

CREATE UNIQUE INDEX antpost__idxv1 ON
    antecedentes_postulacion (
        id_inst_aca
    ASC );

ALTER TABLE antecedentes_postulacion ADD CONSTRAINT antecedentes_postulacion_pk PRIMARY KEY ( id_ant_post );

CREATE TABLE ciudad (
    id_ciud      NUMBER(3) NOT NULL,
    nombre_ciud  VARCHAR2(25) NOT NULL,
    id_dir       NUMBER(3) NOT NULL,
    id_reg       NUMBER(3) NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciud );

CREATE TABLE direccion (
    id_dir        NUMBER(3) NOT NULL,
    direccion     VARCHAR2(150) NOT NULL,
    tipo_direc    VARCHAR2(20) NOT NULL,
    envio_correos VARCHAR2(20) NOT NULL,
    opciones      VARCHAR2(150) NOT NULL,
    run_post      NUMBER NOT NULL
);

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( id_dir );

CREATE TABLE estado_civil (
    id_civil  NUMBER(3) NOT NULL,
    nombre    VARCHAR2(20) NOT NULL
);

CREATE UNIQUE INDEX estado_civil__idx ON
    estado_civil (
        id_civil
    ASC );

ALTER TABLE estado_civil ADD CONSTRAINT estado_civil_pk PRIMARY KEY ( id_civil );

CREATE TABLE estudios (
    id_est            NUMBER(3) NOT NULL,
    pais_estu_sec     VARCHAR2(25) NOT NULL,
    dep_estab_edu     VARCHAR2(50) NOT NULL,
    tipo_estab_edu    VARCHAR2(50) NOT NULL,
    tipo_ingreso_uni  VARCHAR2(50) NOT NULL,
    nota              NUMBER(3, 1) NOT NULL,
    postulante_run    NUMBER NOT NULL
);

ALTER TABLE estudios ADD CONSTRAINT estudios_pk PRIMARY KEY ( id_est );

CREATE TABLE experiencia_laboral (
    id_exp               NUMBER(3) NOT NULL,
    tipo_experiencia     VARCHAR2(30) NOT NULL,
    institucion_empresa  VARCHAR2(50) NOT NULL,
    fecha_ini            DATE NOT NULL,
    fecha_ter            DATE NOT NULL,
    postulante_run       NUMBER NOT NULL
);

ALTER TABLE experiencia_laboral ADD CONSTRAINT experiencia_laboral_pk PRIMARY KEY ( id_exp );

CREATE TABLE financiamiento (
    id_fin      NUMBER(3) NOT NULL,
    nombre_fin  VARCHAR2(30) NOT NULL
);

CREATE UNIQUE INDEX financiamiento__idx ON
    financiamiento (
        id_fin
    ASC );

ALTER TABLE financiamiento ADD CONSTRAINT financiamiento_pk PRIMARY KEY ( id_fin );

CREATE TABLE hijo (
    rut_hijo        NUMBER NOT NULL,
    dv              CHAR(1) NOT NULL,
    p_nombre        VARCHAR2(30) NOT NULL,
    s_nombre        VARCHAR2(30) NOT NULL,
    apellido_pa     VARCHAR2(30) NOT NULL,
    apellido_ma     VARCHAR2(30) NOT NULL,
    fech_nac        DATE NOT NULL,
    postulante_run  NUMBER
);

ALTER TABLE hijo ADD CONSTRAINT hijo_pk PRIMARY KEY ( rut_hijo );

CREATE TABLE institucion_academica (
    id_inst        NUMBER(3) NOT NULL,
    nombre         VARCHAR2(50) NOT NULL,
    ranking        NUMBER(3) NOT NULL,
    pais           VARCHAR2(50) NOT NULL,
    ciudad         VARCHAR2(50) NOT NULL,
    id_subesp_med  NUMBER(3) NOT NULL
);

CREATE UNIQUE INDEX instacade__idx ON
    institucion_academica (
        id_inst
    ASC );

CREATE UNIQUE INDEX instacade__idxv1 ON
    institucion_academica (
        id_subesp_med
    ASC );

ALTER TABLE institucion_academica ADD CONSTRAINT institucion_academica_pk PRIMARY KEY ( id_inst );

CREATE TABLE objetivos (
    id           NUMBER(3) NOT NULL,
    observacion  VARCHAR2(30) NOT NULL,
    id_ant_post  NUMBER(3) NOT NULL
);

ALTER TABLE objetivos ADD CONSTRAINT objetivos_pk PRIMARY KEY ( id );

CREATE TABLE intereses (
    id           NUMBER(3) NOT NULL,
    observacion  VARCHAR2(30) NOT NULL,
    id_ant_post  NUMBER(3) NOT NULL
);

ALTER TABLE intereses ADD CONSTRAINT intereses_pk PRIMARY KEY ( id );

CREATE TABLE participacion_proyecto (
    id_pro    NUMBER(3) NOT NULL,
    titulo    VARCHAR2(30) NOT NULL,
    post_run  NUMBER,
    id_finan  NUMBER(3) NOT NULL
);

ALTER TABLE participacion_proyecto ADD CONSTRAINT participacion_proyecto_pk PRIMARY KEY ( id_pro );

CREATE TABLE postulacion (
    id_post   NUMBER(3) NOT NULL,
    post_run  NUMBER NOT NULL
);

CREATE UNIQUE INDEX postulacion__idx ON
    postulacion (
        id_post
    ASC );



ALTER TABLE postulacion ADD CONSTRAINT postulacion_pk PRIMARY KEY ( id_post );

CREATE TABLE postulante (
    run             NUMBER NOT NULL,
    dv              CHAR(1) NOT NULL,
    p_nombre        VARCHAR2(30) NOT NULL,
    s_nombre        VARCHAR2(30) NOT NULL,
    apellido_pa     VARCHAR2(30) NOT NULL,
    apellido_ma     VARCHAR2(30) NOT NULL,
    fecha_nac       DATE NOT NULL,
    nacionalidad    VARCHAR2(20) NOT NULL,
    sexo            VARCHAR2(15) NOT NULL,
    pasaporte_visa  VARCHAR2(20),
    pueblo_ori      VARCHAR2(20),
    discapacidad    VARCHAR2(15),
    id_civil        NUMBER(3) NOT NULL
);

ALTER TABLE postulante ADD CONSTRAINT postulante_pk PRIMARY KEY ( run );

CREATE TABLE puntaje_civil (
    id            NUMBER(3) NOT NULL,
    estado_civil  VARCHAR2(20) NOT NULL,
    puntaje       NUMBER(2) NOT NULL
);

ALTER TABLE puntaje_civil ADD CONSTRAINT puntaje_civil_pk PRIMARY KEY ( id );

CREATE TABLE puntaje_doc_inv (
    id       NUMBER(3) NOT NULL,
    grado    VARCHAR2(20) NOT NULL,
    puntaje  NUMBER(3) NOT NULL
);

CREATE TABLE puntaje_edad (
    id       NUMBER(3) NOT NULL,
    ed_min   NUMBER(3) NOT NULL,
    ed_max   NUMBER(3) NOT NULL,
    puntaje  NUMBER(2) NOT NULL
);

ALTER TABLE puntaje_edad ADD CONSTRAINT puntaje_edad_pk PRIMARY KEY ( id );

CREATE TABLE puntaje_exp_lab (
    id       NUMBER(3) NOT NULL,
    annos    NUMBER(3) NOT NULL,
    puntaje  NUMBER(3) NOT NULL
);

ALTER TABLE puntaje_exp_lab ADD CONSTRAINT puntaje_exp_lab_pk PRIMARY KEY ( id );

CREATE TABLE puntaje_intereses (
    id       NUMBER(3) NOT NULL,
    grado    VARCHAR2(20) NOT NULL,
    puntaje  NUMBER(3) NOT NULL
);

ALTER TABLE puntaje_intereses ADD CONSTRAINT puntaje_intereses_pk PRIMARY KEY ( id );

CREATE TABLE puntaje_notas (
    id        NUMBER(3) NOT NULL,
    nota_min  NUMBER(3, 1) NOT NULL,
    nota_max  NUMBER(3, 1) NOT NULL,
    puntaje   NUMBER(3) NOT NULL
);

ALTER TABLE puntaje_notas ADD CONSTRAINT puntaje_notas_pk PRIMARY KEY ( id );

CREATE TABLE puntaje_obj_est (
    id       NUMBER(3) NOT NULL,
    grado    VARCHAR2(20) NOT NULL,
    puntaje  NUMBER(3) NOT NULL
);

ALTER TABLE puntaje_obj_est ADD CONSTRAINT puntaje_obj_est_pk PRIMARY KEY ( id );

CREATE TABLE puntaje_rank_inst (
    id        NUMBER(3) NOT NULL,
    rank_min  NUMBER(2) NOT NULL,
    rank_max  NUMBER(3) NOT NULL,
    puntaje   NUMBER(3) NOT NULL
);

ALTER TABLE puntaje_rank_inst ADD CONSTRAINT puntaje_rank_inst_pk PRIMARY KEY ( id );

CREATE TABLE puntaje_retri_post (
    id       NUMBER(3) NOT NULL,
    grado    VARCHAR2(20) NOT NULL,
    puntaje  NUMBER(3) NOT NULL
);

ALTER TABLE puntaje_retri_post ADD CONSTRAINT puntaje_retri_post_pk PRIMARY KEY ( id );

CREATE TABLE puntaje_zona_ext (
    id       NUMBER(3) NOT NULL,
    zona     VARCHAR2(50) NOT NULL,
    puntaje  NUMBER(3) NOT NULL
);

CREATE TABLE region (
    id_reg          NUMBER(3) NOT NULL,
    nombre_reg      VARCHAR2(50)
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_reg );

CREATE TABLE sub_esp_medica (
    id_subesp  NUMBER(3) NOT NULL,
    nombre     VARCHAR2(25) NOT NULL
);

CREATE UNIQUE INDEX subesp_med_idx ON
    sub_esp_medica (
        id_subesp
    ASC );

ALTER TABLE sub_esp_medica ADD CONSTRAINT sub_esp_medica_pk PRIMARY KEY ( id_subesp );

CREATE TABLE titulos (
    id_tit          NUMBER(3) NOT NULL,
    institucion     VARCHAR2(50) NOT NULL,
    nombre_carrera  VARCHAR2(45) NOT NULL,
    fecha_obten     DATE NOT NULL,
    postulante_run  NUMBER NOT NULL
);

ALTER TABLE titulos ADD CONSTRAINT titulos_pk PRIMARY KEY ( id_tit );

CREATE TABLE DETALLE_POSTULACION_BECA (
    run_postulante              VARCHAR2(50) NOT NULL,
    nombre_postulante           VARCHAR2(50) NOT NULL,
    fecha_postulacion           DATE NOT NULL,
    est_civil                   VARCHAR2(50) NOT NULL,
    direccion                   VARCHAR2(150) NOT NULL,
    subespecialidad_postulada   VARCHAR2(50) NOT NULL,
    institucion_academica       VARCHAR2(50) NOT NULL,
    ciudad                      VARCHAR2(50) NOT NULL,
    pais                        VARCHAR2(50) NOT NULL
);

ALTER TABLE DETALLE_POSTULACION_BECA ADD CONSTRAINT detalles_beca_pk PRIMARY KEY ( run_postulante );


CREATE TABLE POSTU_REGION(
    region VARCHAR2 (50) NOT NULL,
    postul NUMBER (3) NOT NULL
);

ALTER TABLE POSTU_REGION ADD CONSTRAINT postu_reg_pk PRIMARY KEY ( region );

CREATE TABLE PUNTAJES_POSTULANTE (
    run_postulante      VARCHAR2(30) NOT NULL,
    nombre_postulante   VARCHAR2(50) NOT NULL,
    edad_postulante     NUMERIC(3) NOT NULL,
    puntaje_edad        NUMERIC(3) NOT NULL,
    estado_civil        VARCHAR2(30) NOT NULL,
    puntaje_est_civil   NUMERIC(3) NOT NULL,
    pueblo_ori          VARCHAR2(30),
    puntaje_pueblo_ori  NUMERIC(3) NOT NULL,
    puntaje_zona_ex     NUMERIC(3) NOT NULL,
    puntaje_ant_acad    NUMERIC(3) NOT NULL,
    puntaje_tray_lab    NUMERIC(3) NOT NULL,
    puntaje_doc_inv     NUMERIC(3) NOT NULL,
    puntaje_objetivo    NUMERIC(3) NOT NULL,
    puntaje_interes     NUMERIC(3) NOT NULL,
    puntaje_retrib      NUMERIC(3) NOT NULL,
    puntaje_rank        NUMERIC(3) NOT NULL,
    puntaje_total       NUMERIC(3) NOT NULL
);

CREATE TABLE REG_ERROR (
    IDERROR      NUMERIC(10),
    BLOQUE      VARCHAR2(150) ,
    VCOD_ORA     NUMERIC(10) ,
    VMEN_ORA        VARCHAR2(150)
);

CREATE TABLE PUNTAJES_POSTULANTE_ETAPA3 (
    run_postulante      VARCHAR2(30) NOT NULL,
    nombre_postulante   VARCHAR2(50) NOT NULL,
    edad_postulante     NUMERIC(3) NOT NULL,
    puntaje_edad        NUMERIC(3) NOT NULL,
    estado_civil        VARCHAR2(30) NOT NULL,
    puntaje_est_civil   NUMERIC(3) NOT NULL,
    pueblo_ori          VARCHAR2(30),
    puntaje_pueblo_ori  NUMERIC(3) NOT NULL,
    zona_extrema        VARCHAR2(50) , 
    puntaje_zona_ex     NUMERIC(3) NOT NULL,
    antecedente_academico NUMERIC(5) NOT NULL,
    puntaje_ant_acad    NUMERIC(3) NOT NULL,
    trayect_lab_anos        VARCHAR2(50), 
    puntaje_tray_lab    NUMERIC(3) NOT NULL,
    docencia_investigacion VARCHAR2(50) ,
    puntaje_doc_inv     NUMERIC(3) NOT NULL,
    objetivo_estudio    VARCHAR2(50) ,
    puntaje_objetivo    NUMERIC(3) NOT NULL,
    interes             VARCHAR2(50) ,
    puntaje_interes     NUMERIC(3) NOT NULL,
    retribucion         VARCHAR2(50),
    puntaje_retrib      NUMERIC(3) NOT NULL,
    inst_educ_extranjera VARCHAR2(50),   
    puntaje_rank        NUMERIC(3) NOT NULL,
    puntaje_total       NUMERIC(3) 
);


ALTER TABLE PUNTAJES_POSTULANTE ADD CONSTRAINT pun_postu_pk PRIMARY KEY ( run_postulante );

ALTER TABLE antecedentes_postulacion
    ADD CONSTRAINT ant_postul_inst_acad_fk FOREIGN KEY ( id_inst_aca )
        REFERENCES institucion_academica ( id_inst );

ALTER TABLE antecedentes_postulacion
    ADD CONSTRAINT ant_postul_post_fk FOREIGN KEY ( id_postul )
        REFERENCES postulacion ( id_post );

ALTER TABLE ciudad
    ADD CONSTRAINT ciu_dir_fk FOREIGN KEY ( id_dir )
        REFERENCES direccion ( id_dir );

ALTER TABLE direccion
    ADD CONSTRAINT dir_post_fk FOREIGN KEY ( run_post )
        REFERENCES postulante ( run );

ALTER TABLE estudios
    ADD CONSTRAINT estud_pos_fk FOREIGN KEY ( postulante_run )
        REFERENCES postulante ( run );

ALTER TABLE experiencia_laboral
    ADD CONSTRAINT exp_lab_post_fk FOREIGN KEY ( postulante_run )
        REFERENCES postulante ( run );

ALTER TABLE hijo
    ADD CONSTRAINT hijo_post_fk FOREIGN KEY ( postulante_run )
        REFERENCES postulante ( run );

ALTER TABLE institucion_academica
    ADD CONSTRAINT inst_aca_sub_esp_med_fk FOREIGN KEY ( id_subesp_med )
        REFERENCES sub_esp_medica ( id_subesp );

ALTER TABLE objetivos_intereses
    ADD CONSTRAINT obj_inter_ant_postul_fk FOREIGN KEY ( id_ant_post )
        REFERENCES antecedentes_postulacion ( id_ant_post );

ALTER TABLE participacion_proyecto
    ADD CONSTRAINT part_proy_financ_fk FOREIGN KEY ( id_finan )
        REFERENCES financiamiento ( id_fin );

ALTER TABLE participacion_proyecto
    ADD CONSTRAINT part_proy_post_fk FOREIGN KEY ( post_run )
        REFERENCES postulante ( run );

ALTER TABLE postulante
    ADD CONSTRAINT post_est_civil_fk FOREIGN KEY ( id_civil )
        REFERENCES estado_civil ( id_civil );

ALTER TABLE postulacion
    ADD CONSTRAINT postu_post_fk FOREIGN KEY ( post_run )
        REFERENCES postulante ( run );

ALTER TABLE region
    ADD CONSTRAINT region_ciudad_fk FOREIGN KEY ( id_ciud )
        REFERENCES ciudad ( id_ciud );

ALTER TABLE titulos
    ADD CONSTRAINT tit_post_fk FOREIGN KEY ( postulante_run )
        REFERENCES postulante ( run );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            27
-- CREATE INDEX                            10
-- ALTER TABLE                             41
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   2
-- WARNINGS                                 0

