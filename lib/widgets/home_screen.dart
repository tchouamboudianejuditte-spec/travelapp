import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Destination> destinations = [
    Destination(
      name: "Paris",
      image: "assets/images/paris.jpg",
      shortDesc: "City of Lights",
      fullDesc: "Paris is beautiful and romantic.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Travel Guide")),
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final destination = destinations[index];

          return Card(
            child: Column(
              children: [
                Image.network(destination.image),
                Text(destination.name),
                Text(destination.shortDesc),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(destination: destination),
                      ),
                    );
                  },
                  child: const Text("View Details"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
