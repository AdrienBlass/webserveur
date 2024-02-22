import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'cartographie.dart';
import 'Evenement.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  List<Evenement> events = [
    Evenement("Adrien", "Incendie", "Le tram est en panne a cause de aezrc azera azdcazdziehrk ekfjvn de azdjfasd azer s", "Famars", 50.65315844, 3.514865, "21 fevrier", false, 0),
    Evenement("Adrien", "Incendie", "Le tram est en panne a cause de aezrc azera azdcazdziehrk ekfjvn de azdjfasd azer s", "Famars", 50.65315844, 3.514865, "21 fevrier", false, 0),
    Evenement("Adrien", "Incendie", "Le tram est en panne a cause de aezrc azera azdcazdziehrk ekfjvn de azdjfasd azer s", "Famars", 50.65315844, 3.514865, "21 fevrier", false, 0),

  ];
  var cityname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        // Wrap the button and list view with a container for padding
        children: [
          Container(
            padding: const EdgeInsets.all(16.0), // Add padding around button
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cartographie(),
                      ),
                    );
                  },
                  child: const Text('Cartographie'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return InkWell (
                  onTap: () {},
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.flag_circle),
                      title: Text('${event.type} à ${event.ville}'),
                      subtitle: Text('${event.auteur} \n${event.description}' ),

                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
