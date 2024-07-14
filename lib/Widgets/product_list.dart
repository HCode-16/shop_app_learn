import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/Widgets/product_card.dart';
import 'package:shop_app/Pages/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata'];

  final searchText = TextEditingController();

  List productnow = products;

  late String selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  void searchTitleProduct(String query) {
    final searchTitle = products.where((product) {
      final titleProduct = product['title'].toString().toLowerCase();
      final searchText = query.toLowerCase();
      return titleProduct.contains(searchText);
    }).toList();

    setState(() {
      productnow = searchTitle;
    });
  }

  void filterCompany(String query) {
    final filterCompany = products.where((product) {
      final companyTitle = product['company'].toString().toLowerCase();
      final selectCompany = query.toLowerCase();

      return companyTitle.contains(selectCompany);
    }).toList();
    if (query == 'All') {
      return setState(() {
        productnow = products;
      });
    }
    return setState(() {
      productnow = filterCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide:
            BorderSide(color: const Color.fromRGBO(224, 224, 224, 1), width: 1),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), topLeft: Radius.circular(50)));
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Shoes\nCollection',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: searchText,
                  decoration: InputDecoration(
                      border: border,
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      enabled: true,
                      enabledBorder: border,
                      focusedBorder: border),
                  onChanged: searchTitleProduct,
                ),
              )
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 95,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final name = filters[index].toString();
                return GestureDetector(
                  onTap: () {
                    if (filters.contains(name)) {
                      setState(() {
                        selectedFilter = name;
                      });
                    }
                    filterCompany(selectedFilter);
                    print(selectedFilter);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Chip(
                      backgroundColor: selectedFilter == name
                          ? Theme.of(context).colorScheme.primary
                          : Color.fromRGBO(248, 252, 255, 1),
                      side: BorderSide(color: Color.fromRGBO(188, 222, 255, 1)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      label: Text(name),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            return constraints.maxWidth > 650
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.95),
                    itemCount: productnow.length,
                    itemBuilder: (context, index) {
                      final product = productnow[index];
                      final nameproduct = product['title'];
                      final priceproduct = product['price'];
                      final imageproduct = product['imageUrl']!;
                      final companyproduct = product['company'];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                      product: product,
                                    ))),
                        child: ProductCard(
                          image: imageproduct,
                          name: nameproduct,
                          price: priceproduct,
                          company: companyproduct,
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: productnow.length,
                    itemBuilder: (context, index) {
                      final product = productnow[index];
                      final nameproduct = product['title'];
                      final priceproduct = product['price'];
                      final imageproduct = product['imageUrl']!;
                      final companyproduct = product['company'];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                      product: product,
                                    ))),
                        child: ProductCard(
                          image: imageproduct,
                          name: nameproduct,
                          price: priceproduct,
                          company: companyproduct,
                        ),
                      );
                    },
                  );
          }))
        ],
      ),
    );
  }
}
