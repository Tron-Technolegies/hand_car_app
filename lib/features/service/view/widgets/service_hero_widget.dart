import 'package:flutter/material.dart';

class PaintServiceDetails extends StatelessWidget {
  final String image;
  final String title;
  final String title2;
  final String rating;
  final String price;
  const PaintServiceDetails({super.key, required this.image, required this.title, required this.title2, required this.rating, required this.price, });

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paint Service Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Go back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Hero(
          tag: 'paintServiceHero',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  image, // Replace with your image asset
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
          
              // Title
              Text(
               title ,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              
              // Rating and Price
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text('4.0'),
                    ],
                  ),
                  Text(
                    'AED 99/hr',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          
              // Address Section
              const SizedBox(height: 16),
              const Text(
                'Address',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'M-33, MUSSAFAH, PLOT NO 26, STORE NO 2 POST BOX NO 37511 '
                'TEL: 025544140 ABUDHABI\nGoogle coordinates: 24°21\'23.5"N 54°30\'32.2"E - Abu Dhabi - United Arab Emirates',
                style: TextStyle(color: Colors.grey[600]),
              ),
          
              // Services Section
              const SizedBox(height: 16),
              const Text(
                'Services',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
               "" ,
                style: TextStyle(color: Colors.grey[700]),
              ),
          
              const SizedBox(height: 16),
          
              // Coupon Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      '20% discount coupon applied.',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 16),
          
              // Contact Buttons
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // WhatsApp logic
                      },
                      icon: const Icon(Icons.local_phone_rounded),
                      label: const Text('WhatsApp us'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Call logic
                      },
                      icon: const Icon(Icons.phone),
                      label: const Text('Call us'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Mail logic
                      },
                      icon: const Icon(Icons.mail),
                      label: const Text(''),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}