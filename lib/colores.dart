import 'package:apis/getApi.dart';
import 'package:flutter/material.dart';

class Vista2 extends StatefulWidget {
  const Vista2({super.key});

  @override
  State<Vista2> createState() => _Vista2State();
}

class _Vista2State extends State<Vista2> {
  List val = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              val.isNotEmpty ? Row(
                children: [
                  //CONTENEDORES
                ],
              ) : Container()
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.large(
                onPressed: () {
                  setState(() {
                    getJsonData();
                  });
                },
                backgroundColor: Colors.blueAccent,
                child: const Text(
                  'Solicitar los colores', textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getJsonData() async {
    //Llamado a la clase
    Colores colores = Colores(
      nombre: 'Alejandro Ordaz',
    );

    try {
      var data;
      //LLamado a la funcion que solicita a la api las coordenadas
      data = await colores.getColores();
      if(data['estatus'] == 200) {
        val = [];
        print(data); //json completo
        print(data['estatus']);
        print(data['respuesta']);
        print(data['respuesta'][1]);
        print(data['respuesta'][1]['nombreColor']);
        for (int i = 0; i < lengthList(data['respuesta']); i++){
          print(data['respuesta'][i]);
          val.add(data['respuesta'][i]['valorHex']);
        }
        print(val);
      } else {
        print('Lista vacia');
      }
    } catch(e) {
      print('Hubo un error al extraer las coordenadas');
    }

    setState(() {});
  }

  int lengthList(var list) {
    int num = 0;
    try {
      for(var cad in list) {
        num = num + 1;
      }
    } catch(e) {
      num = 0;
    }
    return num;
  }
}
