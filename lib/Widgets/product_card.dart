import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key, this.name, this.price, this.image, this.company});

  final name;
  final price;
  final image;
  final company;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: company == 'Adidas'
            ? Colors.cyan[100]
            : company == 'Nike'
                ? Colors.grey[200]
                : Colors.green[200],
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '\$${price}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Image.asset(
                image.toString(),
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
    );
  }
}
