<?php
import $call_config_server;
    $nombre = $_GET['name'];
    $apellidos = $_GET['apellidos'];
    $arregloFinal = array();
    $arrey2 = array();

    if(!isset($nombre) && !isset($apellidos)){
        $arregloFinal['status'] = 200;
        $arregloFinal['respuesta'] = "Fue un exito!";

        for(int $i = 0; $i < 20; $i++) {
            $arrey2['nombre'] = 'Alejandro';
            $arrey2['edad'] = $i;
            $arrey2['band'] = true;
        }

        $arregloFinal['respuesta2'] = $arrey2;
    } else {
        $arregloFinal['status'] = 500;
        $arregloFinal['respuesta'] = "Fue un fracaso!";
        $arregloFinal['respuesta2'] = $arrey2;
    }

    echo json_encode($arregloFinal);


    {
        "status": 200,
        "respuesta": "Error",
        "respuesta2": [
            {
                "nombre_user": "Alejandro",
                "edad": 12,
                "band": {
                }
            },
        ]
    }
?>