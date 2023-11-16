import 'package:apis/colores.dart';
import 'package:apis/getApi.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late GoogleMapController mapController;

  late LatLng _center = const LatLng(22.144596, -101.009064);

  //Guardar los puntos con las coordenadas (lat, lng)
  final List<LatLng> polyPoints = [];
  //Guardar las lineas sobre el mapa
  final Set<Polyline> polyLines = {};

  final List<Marker> _markers = <Marker>[];

  static const LatLng sourceLocation = LatLng(22.144596, -101.009064);
  static const LatLng destination = LatLng(22.14973, -100.992221);

  @override
  void initState() {
    getJsonData(); // Función que realiza el llamado a la api
    setCustomMarkerIcon(); // Se encarga de crear nuestras marcas personalizadas
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void actualizaCoordenadas(String lat, String lng) {
    _center = LatLng(double.parse(lat), double.parse(lng));
  }

  Future<void> getJsonData() async {
    //Llamado a la clase
    NetworkHelper networkHelper = NetworkHelper(
      startLat: 22.144596,
      startLng: -101.009064,
      endLat: 22.149730,
      endLng: -100.992221,
    );

    try {
      var data;
      //LLamado a la funcion que solicita a la api las coordenadas
      data = await networkHelper.getData();
      print(data); //json completo
      print(data['features']); // atributo 1er nivel
      print(data['features'][0]);
      print(data['features'][0]['geometry']); //atributo secundario
      print(data['features'][0]['geometry']['coordinates']); // 3er
      LineString ls = LineString(data['features'][0]['geometry']['coordinates']);

      for(int i = 0; i < ls.lineString.length; i++){
        print('${ls.lineString[i][1]}, ${ls.lineString[i][0]}');
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if(polyPoints.length == ls.lineString.length) {
        setPolyLines();
      }
    } catch(e) {
      print('Hubo un error al extraer las coordenadas');
    }
  }

  setPolyLines() {
    setState(() {
      ///p1 --------- p2 ------- p3
      Polyline polyline = Polyline(
          polylineId: const PolylineId('polilyne'),
          color: Colors.red,
          width: 5,
          points: polyPoints
      );
      polyLines.add(polyline);
    });
  }

  createMarker() async {
    String iconurl ="https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Catedral_SLP_cielo.jpg/1200px-Catedral_SLP_cielo.jpg";
    var dataBytes;
    var request = await http.get(Uri.parse(iconurl));
    var bytes = await request.bodyBytes;

    setState(() {
      dataBytes = bytes;
    });

    LatLng _lastMapPositionPoints = LatLng(
        double.parse("22.142435"),
        double.parse("-101.009346"));

    _markers.add(Marker(
      icon: BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List()),
      markerId: MarkerId(_lastMapPositionPoints.toString()),
      position: _lastMapPositionPoints,
      infoWindow: const InfoWindow(
        title: "Delivery Point",
        snippet:
        "My Position",
      ),
    ));
  }





  //Imagen -> Marca para visualizar en el mapa
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "img/icon.png").then((icon) {
        sourceIcon = icon;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            polylines: polyLines,
            markers: {
              const Marker(
                markerId: MarkerId("source"),
                position: sourceLocation,
                infoWindow: InfoWindow(title: "Información inicio"),
              ),
              Marker(
                markerId: MarkerId("destination"),
                position: destination,
                icon: sourceIcon,
                infoWindow: const InfoWindow(title: "Información destino"),
                onTap: () {
                  setState(() {
                    showAlertDialog(context);
                  });
                }
              ),
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton.large(
                onPressed: () {
                  setState(() {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => const Vista2()));
                  });
                },
                child: const Text(
                  'Pasar a la siguiente vista', textAlign: TextAlign.center,
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}
