import 'package:apis/getApi.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                      title: Text('Nombre apellidoP apellidoM'),
                      subtitle: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Correo electronico'),
                              Text('telefono')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Calificacion '),
                              Text('Edad '),
                              Text('Pais')
                            ],
                          ),
                        ],
                      ),

                      leading: Icon(Icons.person),
                    ),

                    // Usamos una fila para ordenar los botones del card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(onPressed: (){}, icon: Icon(Icons.update, color: Colors.blue,)),
                        IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    )
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                color: Color(0xA900FFF5),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                      title: Text('Nombre apellidoP apellidoM'),
                      subtitle: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('a@a.com'),
                              Text('444 123 4567')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('100', style: TextStyle(color: Colors.green, fontSize: 20),),
                              Text('Edad '),
                              Text('Mexico')
                            ],
                          ),
                        ],
                      ),

                      leading: Icon(Icons.person),
                    ),

                    // Usamos una fila para ordenar los botones del card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(onPressed: (){}, icon: Icon(Icons.update, color: Colors.blue,)),
                        IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    )
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                color: Colors.black,
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                      title: Text('Nombre apellidoP apellidoM', style: TextStyle(color: Colors.white),),
                      subtitle: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Correo electronico', style: TextStyle(color: Colors.white)),
                              Text('telefono', style: TextStyle(color: Colors.white))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('65 ', style: TextStyle(color: Colors.orange)),
                              Text('Edad ', style: TextStyle(color: Colors.white)),
                              Text('Alemania', style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        ],
                      ),

                      leading: Icon(Icons.person),
                    ),

                    // Usamos una fila para ordenar los botones del card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(onPressed: (){}, icon: Icon(Icons.update, color: Colors.blue,)),
                        IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  _textMe();
                });
              },
              icon: Icon(Icons.sms),
          ),
          IconButton(
            onPressed: (){
              setState(() {
                _callMe();
              });
            },
            icon: Icon(Icons.call),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.yellow, // foreground
                ),
                onPressed: () {
                  setState(() {
                    _textMe();
                    _callMe();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.refresh),
                    Text('Solicitar nuevos usuarios')
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  /*void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }*/

  _callMe() async {
    launch('tel: 4443218456');
  }
  _textMe() async {
    // Android
    // %20 = el espacio
    const uri = 'sms:+4443218456?body=hello%20there%20all';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:0039-222-060-888?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  Future<void> getJsonData() async {
    //Llamado a la clase
    Colores colores = Colores( nombre: 'Alejandro Ordaz', );

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

//marker dynamic
//webview lat, lng atravez de una dirección

