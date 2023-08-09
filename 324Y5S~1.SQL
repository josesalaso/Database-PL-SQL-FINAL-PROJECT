CREATE PROCEDURE SP_PROCE_POSTUL
IS
    CURSOR CUR_DATOS IS
        SELECT 
            P.RUN RUT,
            P.DV DVR,
            INITCAP(P.P_NOMBRE||' '|| P.S_NOMBRE||' '|| P.APELLIDO_PA||' '|| P.APELLIDO_MA) NOM,
            TRUNC(MONTHS_BETWEEN(SYSDATE,P.FECHA_NAC)/12) EDAD,
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
        JOIN S_OBJ OBJ ON ANT.ID_ANT_POST = OBJ.ID_ANT_POST;
        
VCOD_ORA NUMERIC (8);
VMEN_ORA VARCHAR2 (150);
V_PUNTAJE_NOTA NUMERIC (7);
V_PUNTAJE_OBJ NUMERIC (7);
V_PUNTAJE_INTER NUMERIC (7);
V_PUNTAJE_RETRI NUMERIC (7);
BEGIN
    FOR R_D IN CUR_DATOS LOOP
        --PUNTAJE RETRIBUCION
        BEGIN
            SELECT PUNTAJE INTO V_PUNTAJE_RETRI FROM PUNTAJE_RETRI_POST
            WHERE R_D.RETRI = GRADO;
        END;
        --PUNTAJE INTERESES
        BEGIN
            SELECT PUNTAJE INTO V_PUNTAJE_INTER FROM PUNTAJE_INTERESES
            WHERE R_D.INTERESES = GRADO;
            
        END;
        DBMS_OUTPUT.PUT_LINE(R_D.INTERESES);
        DBMS_OUTPUT.PUT_LINE(V_PUNTAJE_INTER);
    
        --PUNTAJE OBJETIVO
        BEGIN
            SELECT PUNTAJE INTO V_PUNTAJE_OBJ FROM PUNTAJE_OBJ_EST
            WHERE R_D.OBJETIVOS = GRADO;
        END;
    
        --PUNTAJE NOTA
        BEGIN
            SELECT PUNTAJE INTO V_PUNTAJE_NOTA FROM PUNTAJE_NOTAS
            WHERE R_D.NOTA BETWEEN NOTA_MIN AND NOTA_MAX;
        EXCEPTION
            WHEN OTHERS THEN
                VCOD_ORA:=SQLCODE;
                VMEN_ORA:=SQLERRM;
                INSERT INTO REG_ERROR VALUES(SEQUENCE_ID.NEXTVAL, 'BLOQUE PUNTAJE NOTA: '||R_D.NOTA,VCOD_ORA,VMEN_ORA);
                V_PUNTAJE_NOTA := 0;
        END;
        --PUNTAJE ESTADO CIVIL
        BEGIN
            SELECT PUNTAJE INTO PKG_INFO_POST.V_PUNTAJE_EST FROM PUNTAJE_CIVIL
            WHERE PKG_INFO_POST.FN_NOMBRE_ESTCIV(R_D.RUT) = ESTADO_CIVIL;
        END;
        
        --PUNTAJE PUEBLO ORIGINARIO
        IF (PKG_INFO_POST.FN_NOMBRE_ORI(R_D.RUT) = 'NO PERTENECE') THEN
            PKG_INFO_POST.V_PUNTAJE_ORI := 0;
        ELSE
            PKG_INFO_POST.V_PUNTAJE_ORI := 5;
        END IF;

        --PUNTAJE ZONA EXTREMA
        BEGIN
            SELECT PUNTAJE INTO PKG_INFO_POST.V_PUNTAJE_ZONA FROM PUNTAJE_ZONA_EXT
            WHERE PKG_INFO_POST.FN_NOMBRE_ZONA(R_D.RUT) = ZONA;
        EXCEPTION
            WHEN OTHERS THEN
                VCOD_ORA:=SQLCODE;
                VMEN_ORA:=SQLERRM;
                INSERT INTO REG_ERROR VALUES(SEQUENCE_ID.NEXTVAL, 'BLOQUE PUNTAJE ZONA EXTREMA: NO PERTENECE',VCOD_ORA,VMEN_ORA);
                PKG_INFO_POST.V_PUNTAJE_ZONA := 0;
        END;
        
        --PUNTAJE DOCENCIA/INVESTIGACION
        BEGIN
            SELECT PUNTAJE INTO PKG_INFO_POST.V_PUNTAJE_DOC FROM PUNTAJE_DOC_INV 
            WHERE R_D.DOC_INVEST = GRADO;
        END;
      INSERT INTO PUNTAJES_POSTULANTE_ETAPA3 VALUES (TO_CHAR(R_D.RUT,'99G999G999')||'-'||R_D.DVR,
                                                       R_D.NOM,
                                                       R_D.EDAD,
                                                       FN_PUNTAJE_EDAD(R_D.RUT),
                                                       PKG_INFO_POST.FN_NOMBRE_ESTCIV(R_D.RUT),
                                                       PKG_INFO_POST.V_PUNTAJE_EST,
                                                       PKG_INFO_POST.FN_NOMBRE_ORI(R_D.RUT),
                                                       PKG_INFO_POST.V_PUNTAJE_ORI,
                                                       PKG_INFO_POST.FN_NOMBRE_ZONA(R_D.RUT),
                                                       PKG_INFO_POST.V_PUNTAJE_ZONA,
                                                       R_D.NOTA,
                                                       V_PUNTAJE_NOTA,
                                                       R_D.ANNOS_LAB || ' años.',
                                                       FN_PUNTAJE_LAB(R_D.RUT),
                                                       R_D.DOC_INVEST,
                                                       PKG_INFO_POST.V_PUNTAJE_DOC,
                                                       R_D.OBJETIVOS,
                                                       V_PUNTAJE_OBJ,
                                                       R_D.INTERESES,
                                                       V_PUNTAJE_INTER,
                                                       R_D.RETRI,
                                                       V_PUNTAJE_RETRI,
                                                       PKG_INFO_POST.FN_NOMBRE_INST(R_D.RUT),
                                                       FN_PUNTAJE_INST(R_D.RUT),NULL);
        
        
    END LOOP;
END SP_PROCE_POSTUL;
