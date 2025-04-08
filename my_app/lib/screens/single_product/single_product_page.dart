import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../widgets/BlueGradientButton.dart';

class SingleProductPage extends StatefulWidget {
  const SingleProductPage({super.key});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

final List<String> imagePaths = [
  'lib/assets/lamp_product_img.jpg',
  'lib/assets/lamp_product_img.jpg',
  'lib/assets/lamp_product_img.jpg',
];

class _SingleProductPageState extends State<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Islamic Investment...', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 289,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Image(
                      image: AssetImage('lib/assets/IslamicProduct.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Islamic Investment Product",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Our comprehensive coverage ensures that your devices are protected against a wide range of mishaps.",
                  ),
                  const Divider(),
                  const Text("Benefits"),
                  const Text(
                    "Theft and loss recovery\nComprehensive coverage\nHardware malfunction coverage",
                  ),
                  const Divider(),
                  const Text("Requirement"),
                  const Text(
                    "Proof of purchase\nValid identification\nProduct serial number",
                  ),
                  const Divider(),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 192.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                    ),
                    items: imagePaths.map((path) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(12.0),
                            width: MediaQuery.of(context).size.width,
                            height: 192.0,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200,
                            ),
                            child: ClipRRect(

                              borderRadius: BorderRadius.circular(15),
                              child: Column(
                                children: [
                                  Image.asset(
                                    path,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Text('Product title'),
                                  Text('from R350 p/m'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          // Fixed bottom bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 4, color: Colors.black12),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('R350.00', style: TextStyle(fontSize: 18)),
                BlueGradientButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
