import 'package:flutter/material.dart';

void main() {
  runApp(const TravelApp());
}

/// Main application widget
class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Guide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

/// Data model for a travel destination
class Destination {
  final String name;
  final String image;
  final String shortDesc;
  final String fullDesc;

  Destination({
    required this.name,
    required this.image,
    required this.shortDesc,
    required this.fullDesc,
  });
}

/// Home screen displaying list of travel destinations
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Sample list of travel destinations
  static final List<Destination> destinations = [
    Destination(
      name: "Paris",
      image:
          "assets/images/paris.png",
      shortDesc: "City of lights and romance",
      fullDesc:
          "Paris is the capital city of France, renowned worldwide for the iconic Eiffel Tower, world-class museums like the Louvre, charming cafés, and its romantic atmosphere. Stroll along the Seine River, visit Notre-Dame Cathedral, and enjoy exquisite French cuisine. The city's art, architecture, and culture make it one of the most visited destinations in the world.",
    ),
    Destination(
      name: "New York",
      image: "assets/images/New York.png",
      shortDesc: "The city that never sleeps",
      fullDesc:
          "New York City, often called 'The Big Apple,' is the most populous city in the United States. It's famous for Times Square's bright lights, Central Park's green spaces, towering skyscrapers, Broadway theaters, and diverse culture. From shopping in SoHo to dining in Greenwich Village, NYC offers endless attractions and entertainment for every visitor.",
    ),
    Destination(
      name: "Tokyo",
      image:
        "assets/images/Tokyo skyline at sunset.png",
      shortDesc: "Modern technology meets tradition",
      fullDesc:
          "Tokyo, Japan's vibrant capital, seamlessly blends ancient temples with cutting-edge technology. Explore neon-lit streets in Shibuya, visit the serene Meiji Shrine, enjoy incredible sushi and ramen, and experience Japanese pop culture. From traditional tea ceremonies to futuristic robots, Tokyo offers a unique contrast of old and new that fascinates every visitor.",
    ),
    Destination(
      name: "Barcelona",
      image: "assets/images/Barcelona.png",
      shortDesc: "Gaudí's architectural masterpiece",
      fullDesc:
          "Barcelona, the capital of Catalonia, is renowned for its unique architecture and vibrant culture. Visit the breathtaking Sagrada Familia basilica and other works by Antoni Gaudí. Enjoy beautiful beaches, delicious tapas, and the lively atmosphere of Las Ramblas. With a rich history blending Roman, Gothic, and modern architecture, Barcelona is an artistic paradise.",
    ),
    Destination(
      name: "Dubai",
      image:
        "assets/images/Dubai.png",
      shortDesc: "Luxury and desert adventure",
      fullDesc:
          "Dubai is a modern metropolis in the United Arab Emirates famous for its luxurious lifestyle, iconic Burj Khalifa (world's tallest building), and stunning architecture. Experience desert safaris, pristine beaches, world-class shopping in the Dubai Mall, and ultramodern entertainment venues. Dubai represents the epitome of contemporary development and Middle Eastern hospitality.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Travel Guide",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return DestinationCard(
            destination: destinations[index],
          );
        },
      ),
    );
  }
}

/// Card widget displaying individual destination information
class DestinationCard extends StatelessWidget {
  final Destination destination;

  const DestinationCard({super.key, required this.destination});

  /// Helper function to load images from either assets or network
  Widget _buildImage(String imagePath, double height) {
    final isLocalAsset = imagePath.startsWith('assets/');
    
    if (isLocalAsset) {
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image_not_supported),
          );
        },
      );
    } else {
      return Image.network(
        imagePath,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image_not_supported),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination image with border radius
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildImage(destination.image, 200),
            ),
            const SizedBox(height: 14),

            // Destination name
            Text(
              destination.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),

            // Short description
            Text(
              destination.shortDesc,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),

            // View Details button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(destination: destination),
                    ),
                  );
                },
                child: const Text(
                  "View Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Detailed view of a destination
class DetailScreen extends StatelessWidget {
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  /// Helper function to load images from either assets or network
  Widget _buildImage(String imagePath, double height) {
    final isLocalAsset = imagePath.startsWith('assets/');
    
    if (isLocalAsset) {
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.image_not_supported),
          );
        },
      );
    } else {
      return Image.network(
        imagePath,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.image_not_supported),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          destination.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Larger destination image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildImage(destination.image, 300),
              ),
            ),

            // Destination name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                destination.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // Full description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                destination.fullDesc,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.6,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 24),

            // Back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.grey[700],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
