CREATE DATABASE IF NOT EXISTS estacionmetereologica_proa;
USE estacionmetereologica_proa;

CREATE TABLE IF NOT EXISTS mediciones (
    id_mediciones INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    temperatura INT,   -- O DECIMAL(4,2) si usan la precisión flotante
    humedad INT,
    gas INT            -- Lectura analógica directa del sensor MQ (Rango 0 a 1023)
);

INSERT INTO mediciones (temperatura, humedad, gas) VALUES (24, 55, 120); -- Óptimo
INSERT INTO mediciones (temperatura, humedad, gas) VALUES (36, 40, 150); -- Alerta Calor
INSERT INTO mediciones (temperatura, humedad, gas) VALUES (22, 60, 480); -- Alerta Fuga de Gas

SELECT 
    fecha_hora,
    temperatura,
    humedad,
    gas,
    CASE 
        WHEN gas > 300 THEN 'ALERTA: GAS / ANOMALÍA EN AIRE'
        WHEN temperatura >= 35 THEN 'ALERTA: CALOR EXTREMO'
         WHEN temperatura <= 15 THEN 'ALERTA: FRÍO EXTREMO'
        ELSE 'ESTADO ÓPTIMO'
    END AS diagnostico_integral
FROM mediciones 
ORDER BY fecha_hora DESC;

SELECT 
    fecha_hora,
    gas,
    CASE 
        WHEN gas > 500 THEN 'ALERTA CRÍTICA: FUGA DE GAS / CONCENTRACIÓN ALTA'
        WHEN gas BETWEEN 250 AND 500 THEN 'ALERTA MEDIA: HUMO / VAPORES EN AIRE'
        WHEN gas BETWEEN 120 AND 249 THEN 'PRECAUCIÓN: AIRE POCO PURO'
        ELSE 'ESTADO ÓPTIMO'
    END AS diagnostico_aire
FROM mediciones 
ORDER BY id_mediciones DESC;


ALTER TABLE mediciones 
ADD COLUMN gas INT AFTER humedad;










