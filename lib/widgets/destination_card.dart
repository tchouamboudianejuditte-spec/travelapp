import 'package:flutter/material.dart';
import 'package:travelapp/main.dart';

class DestinationCard extends StatelessWidget {
final Destination destination;

const DestinationCard({super.key, required this.destination});

@override
Widget build(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal:12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    child: ListTile(
      contentPadding: const EdgeInsets.all(12),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          destination.image,
          width: 80,
          height: 80,
          fit: BoxFit,
        ),
      ),
      title: Text(destination.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(destination.shortDesc),
      onTap: (){
      Navigator.push(contextcontext,
      MaterialPageRoute( 
      builder: (context) =>  DetailScreen(destination: destination),
      ),
      );
      }
      ),
      );
    }
}