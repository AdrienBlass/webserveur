import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'objets/Utilisateur.dart';
import 'pages/cartographie.dart';
import 'objets/Evenement.dart';

String ipServeur = 'ws://localhost';
List<Evenement> events = [];
List<Utilisateur> users = [];
final mqttClient = MqttBrowserClient.withPort(ipServeur,'admin', 1883);
bool chPage = true;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

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
  const MyHomePage({Key? key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    connectToMqtt();
  }

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

  Future<void> connectToMqtt() async {
    try {
      // Connect to the MQTT server
      await mqttClient.connect();

      // Subscribe to MQTT topics
      mqttClient.subscribe('getEvents', MqttQos.atLeastOnce);
      mqttClient.subscribe('majEvent', MqttQos.atLeastOnce);

      // Listen for MQTT updates
      mqttClient.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        final jsonString = pt;
        print('Received message: topic is ${c[0].topic}, payload is $pt');
        List<dynamic> jsonData = jsonDecode(jsonString);
        if(mounted) {
          setState(() {
            events = jsonData.map((json) => Evenement.fromJson(json)).toList();
          });
        }
      });

      // Publish a message
      if(chPage) {
        final builder = MqttClientPayloadBuilder();
        print("send message events/all");
        chPage = false;
        mqttClient.publishMessage(
            'events/all', MqttQos.atLeastOnce, builder.payload!);
      }
    } catch (e) {
      print('Error connecting to MQTT server: $e');
      // Handle error, show a message to the user, retry connection, etc.
    }
  }
}
