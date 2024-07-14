import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Map<String, dynamic> product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${product['title']}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                '${product['imageUrl']}',
                fit: BoxFit.cover,
                width: 400,
                scale: 1,
              ),
            ),
            Spacer(),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.2,
              color: Color.fromRGBO(245, 247, 249, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '\$${product['price']}',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (product['sizes'] as List<int>).length,
                        itemBuilder: (context, index) {
                          final sizes = product['sizes'];
                          final allsizes = sizes[index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = allsizes;
                                  });
                                  print(selectedSize);
                                },
                                child: Chip(
                                    backgroundColor: selectedSize == allsizes
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.white,
                                    label: Text('$allsizes'))),
                          );
                        }),
                  ),
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Add to Cart',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (selectedSize == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          'Pleace select size',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Complete Add to Cart',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold))));
                        Provider.of<CartProvider>(context, listen: false)
                            .addProduct({
                          'id': product['id'],
                          'title': product['title'],
                          'price': product['price'],
                          'size': selectedSize,
                          'imageUrl': product['imageUrl'],
                          'compamy': product['comapany']
                        });
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
