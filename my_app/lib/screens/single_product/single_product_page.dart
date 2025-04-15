import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';

import '../../widgets/BlueGradientButton.dart';

class SingleProductPage extends StatefulWidget {
  const SingleProductPage({super.key});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

final List<String> imagePaths = [
  'lib/assets/lamp_product_img.jpg',
  'lib/assets/cleanerProject.jpg',
  'lib/assets/lamp_product_img.jpg',
];

class ProductCard {
  String title;
  String imagePath;
  String price;

  ProductCard(this.title, this.imagePath, this.price);
}

final List<ProductCard> productCardsList = [
  ProductCard('Product title', imagePaths[0], "from R350 p/m"),
  ProductCard('Product title', imagePaths[1], "from R350 p/m"),
  ProductCard('Product title', imagePaths[2], "from R350 p/m")
];

class _SingleProductPageState extends State<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Islamic Investment...',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
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
                  Text("Islamic Investment Product",
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 8),
                  ReadMoreText(
                    "Our comprehensive coverage ensures that your devices are protected against a wide range of mishaps.",
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Read less',
                    // style: Theme.of(context).textTheme.displaySmall
                    moreStyle:
                        Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: Colors.blue,
                            ),
                    lessStyle:
                        Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: Colors.blue,
                            ),
                  ),
                  const Divider(),
                  Text("Benefits",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                  Text(
                      " • Theft and loss recovery\n • Comprehensive coverage\n • Hardware malfunction coverage",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const Divider(),
                  Text("Requirement",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                  Text(
                    " • Proof of purchase\n • Valid identification\n • Product serial number",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Divider(),
                  ProductList()
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
                Column(children: [
                  Text('R350.00',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                  Text('per month',
                      style: Theme.of(context).textTheme.labelMedium)
                ]),
                BlueGradientButton(
                  text: "Add to cart",
                  width: MediaQuery.of(context).size.width * 0.5,
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

class _SampleCard extends StatelessWidget {
  final ProductCard card;

  const _SampleCard(this.card);

  @override
  Widget build(BuildContext context) {
    var cardWidth = MediaQuery.of(context).size.width * 0.75;

    return Container(
        padding: const EdgeInsets.all(12.0),
        width: cardWidth,
        height: 192,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: 120,
              width: cardWidth,
              child: Image(
                image: AssetImage(card.imagePath),
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(card.title),
            Text(card.price),
          ],
        ));
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          itemCount: productCardsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card.outlined(child: _SampleCard(productCardsList[index]));
          }),
    );
  }
}

// class ProductCarousel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         enlargeCenterPage: false,
//         enableInfiniteScroll: false,
//         autoPlay: true,
//       ),
//       items: imagePaths.map((path) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Card.outlined(child: _SampleCard(productTitle: 'Product title',path:imagePaths[0],price: "from R350 p/m",));
//           },
//         );
//       }).toList(),
//     );
//   }
// }
