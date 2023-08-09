DECLARE
    CURSOR CUR_DAT IS
        SELECT 
            TO_CHAR(P.RUN,'99,999,999')||'-'||P.DV RUT,
            INITCAP(P.P_NOMBRE||' '|| P.S_NOMBRE||' '|| P.APELLIDO_PA||' '|| P.APELLIDO_MA) NOM,
            TRUNC(MONTHS_BETWEEN(SYSDATE,P.FECHA_NAC)/12) EDAD,
            EST.NOMBRE EST_CIV,
            P.PUEBLO_ORI ORI,
            R.NOMBRE_REG REGION,
            ESTU.NOTA NOTA,
            TRUNC(MONTHS_BETWEEN(EXP.FECHA_TER,EXP.FECHA_INI)/12) ANNOS_LAB,
            OBJ.OBSERVACION OBJETIVOS,
            INTE.OBSERVACION INTERESES,
            INST.RANKING RANK,
            ANT.DOC_INVEST DOC_INVEST,
            ANT.RETRIBUCION RETRI
        FROM S_POST P 
        JOIN S_EST EST ON P.ID_CIVIL = EST.ID_CIVIL
        JOIN S_DIR D ON P.RUN = D.RUN_POST
        JOIN S_CIUD C ON C.ID_DIR = D.ID_DIR
        JOIN S_REG R ON C.ID_REG = R.ID_REG
        JOIN S_POSTU PS ON P.RUN = PS.POST_RUN
        JOIN S_ANTPOST ANT ON PS.ID_POST = ANT.ID_POSTUL
        JOIN S_INST INST ON ANT.ID_INST_ACA = INST.ID_INST
        JOIN S_EXP EXP ON P.RUN = EXP.POSTULANTE_RUN
        JOIN S_ESTU ESTU ON P.RUN = ESTU.POSTULANTE_RUN
        JOIN S_INTER INTE ON ANT.ID_ANT_POST = INTE.ID_ANT_POST
        JOIN S_OBJ OBJ ON ANT.ID_ANT_POST = OBJ.ID_ANT_POST ;

V_PUNTAJE_EDAD  NUMERIC(3);
V_PUNTAJE_CIVIL NUMERIC(3);
V_PUNTAJE_ORI   NUMERIC(3);
V_PUNTAJE_ZONA  NUMERIC(3);
V_PUNTAJE_ANTE  NUMERIC(3);
V_PUNTAJE_EXP   NUMERIC(3);
V_PUNTAJE_DOC   NUMERIC(3);
V_PUNTAJE_OBJ   NUMERIC(3);
V_PUNTAJE_INTE  NUMERIC(3);
V_PUNTAJE_RETR  NUMERIC(3);
V_PUNTAJE_RANK  NUMERIC(3);
V_PUNTAJE_TOTAL NUMERIC(3);

BEGIN
    FOR REG_CUR_DAT IN CUR_DAT LOOP
        V_PUNTAJE_EDAD := CASE 
                            WHEN REG_CUR_DAT.EDAD BETWEEN 1 AND 29 THEN 5
                            WHEN REG_CUR_DAT.EDAD BETWEEN 30 AND 40 THEN 3
                            ELSE 1
                          END;
        V_PUNTAJE_CIVIL := CASE REG_CUR_DAT.EST_CIV
                            WHEN 'CASADO' THEN 5
                            WHEN 'CONVIVIENTE CIVIL' THEN 4
                            WHEN 'SOLTERO' THEN 3
                            WHEN 'DIVORCIADO' THEN 2
                            ELSE 1
                           END;
        IF (REG_CUR_DAT.ORI = 'SI') THEN
            V_PUNTAJE_ORI := 5;
        ELSE 
            V_PUNTAJE_ORI := 0;
        END IF;
        V_PUNTAJE_ZONA := CASE REG_CUR_DAT.REGION
                            WHEN 'ARICA Y PARINACOTA' THEN 5
                            WHEN 'TARAPACÁ' THEN 4
                            WHEN 'AYSEN' THEN 4
                            WHEN 'MAGALLANES Y DE LA ANTARTIDA CHILENA' THEN 5
                            ELSE 0
                          END;
        V_PUNTAJE_ANTE := CASE
                            WHEN REG_CUR_DAT.NOTA BETWEEN 6.6 AND 7 THEN 5
                            WHEN REG_CUR_DAT.NOTA BETWEEN 6.0 AND 6.5 THEN 4
                            WHEN REG_CUR_DAT.NOTA BETWEEN 5.5 AND 5.9 THEN 3
                            WHEN REG_CUR_DAT.NOTA BETWEEN 5.2 AND 5.4 THEN 2
                            WHEN REG_CUR_DAT.NOTA BETWEEN 5.0 AND 5.1 THEN 1
                            ELSE 0
                          END;   
        V_PUNTAJE_EXP := CASE
                            WHEN REG_CUR_DAT.ANNOS_LAB > 5 THEN 5
                            WHEN REG_CUR_DAT.ANNOS_LAB = 5 THEN 4
                            WHEN REG_CUR_DAT.ANNOS_LAB = 4 THEN 3
                            WHEN REG_CUR_DAT.ANNOS_LAB = 3 THEN 2
                            WHEN REG_CUR_DAT.ANNOS_LAB = 2 THEN 1
                            ELSE 0
                         END; 
        V_PUNTAJE_DOC := CASE REG_CUR_DAT.DOC_INVEST 
                            WHEN 'ALTO' THEN 5
                            WHEN 'MEDIO' THEN 3
                            WHEN 'BAJO' THEN 2
                            ELSE 0
                         END;
        V_PUNTAJE_OBJ := CASE REG_CUR_DAT.OBJETIVOS
                            WHEN 'EXCELENTE' THEN 5
                            WHEN 'MUY BUENO' THEN 4
                            WHEN 'BUENO' THEN 3
                            WHEN 'REGULAR' THEN 1
                            ELSE 0
                         END;
        V_PUNTAJE_INTE := CASE REG_CUR_DAT.INTERESES
                            WHEN 'EXCELENTE' THEN 5
                            WHEN 'MUY BUENO' THEN 4
                            WHEN 'BUENO' THEN 3
                            WHEN 'REGULAR' THEN 1
                            ELSE 0
                         END;
        V_PUNTAJE_RETR := CASE REG_CUR_DAT.RETRI
                            WHEN 'EXCELENTE' THEN 5
                            WHEN 'MUY BUENO' THEN 4
                            WHEN 'BUENO' THEN 3
                            WHEN 'REGULAR' THEN 1
                            ELSE 0
                         END;
        V_PUNTAJE_RANK := CASE 
                            WHEN REG_CUR_DAT.RANK BETWEEN 1 AND 10 THEN 5
                            WHEN REG_CUR_DAT.RANK BETWEEN 11 AND 20 THEN 4
                            WHEN REG_CUR_DAT.RANK BETWEEN 21 AND 30 THEN 3
                            WHEN REG_CUR_DAT.RANK BETWEEN 31 AND 50 THEN 2
                            ELSE 1
                         END;
        V_PUNTAJE_TOTAL := V_PUNTAJE_EDAD + V_PUNTAJE_CIVIL + V_PUNTAJE_ORI + V_PUNTAJE_ZONA + V_PUNTAJE_ANTE
                           + V_PUNTAJE_EXP + V_PUNTAJE_DOC + V_PUNTAJE_OBJ + V_PUNTAJE_INTE + V_PUNTAJE_RETR + V_PUNTAJE_RANK;
        INSERT INTO PUN_POST (RUN_POSTULANTE, NOMBRE_POSTULANTE, EDAD_POSTULANTE, PUNTAJE_EDAD, ESTADO_CIVIL, PUNTAJE_EST_CIVIL, 
                              PUEBLO_ORI, PUNTAJE_PUEBLO_ORI, PUNTAJE_ZONA_EX, PUNTAJE_ANT_ACAD, PUNTAJE_TRAY_LAB, PUNTAJE_DOC_INV, 
                              PUNTAJE_OBJETIVO, PUNTAJE_INTERES, PUNTAJE_RETRIB, PUNTAJE_RANK, PUNTAJE_TOTAL)
                              VALUES (REG_CUR_DAT.RUT, REG_CUR_DAT.NOM,REG_CUR_DAT.EDAD,V_PUNTAJE_EDAD,REG_CUR_DAT.EST_CIV,V_PUNTAJE_CIVIL,
                                      REG_CUR_DAT.ORI,V_PUNTAJE_ORI,V_PUNTAJE_ZONA,V_PUNTAJE_ANTE,V_PUNTAJE_EXP,V_PUNTAJE_DOC,V_PUNTAJE_OBJ,
                                      V_PUNTAJE_INTE,V_PUNTAJE_RETR,V_PUNTAJE_RANK,V_PUNTAJE_TOTAL );
    END LOOP;
END;
/
SELECT * FROM PUN_POST;

/

CREATE OR REPLACE VIEW PUNTAJE_POSTULANTE AS
SELECT *
FROM PUN_POST;


commit;
rollback;
