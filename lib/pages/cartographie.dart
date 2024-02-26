import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../objets/Utilisateur.dart';
class Cartographie extends StatelessWidget {
  const Cartographie({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ServeurWeb',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Serveur Web'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=> MyApp(),
                    ));
                  },
                  child: Text('DashBoard'),
                ),
              ],
            ),
            Expanded(
                child:FlutterMap(
                  options: MapOptions(
                    center: LatLng(50.326085, 3.514633),
                    zoom:16 ,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: users.map((user) {
                        final latitude = user.longitude;
                        final longitude = user.latitude;
                        return Marker(
                          width: 90.0,
                          height: 50.0,
                          point: LatLng(latitude, longitude),
                          builder: (context) => Container(
                        decoration: BoxDecoration(
                        color: Colors.red,  // Customize background color
                        borderRadius: BorderRadius.circular(5.0),
                        ),
                            child: Center(
                             child: Text('''${user.pseudo} ${user.scoreConfiance}''' , style: TextStyle(color: Colors.white)),
                              // Use user.nom for name
                          ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

            )
          ],
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }
}
