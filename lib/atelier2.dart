import 'package:flutter/material.dart';
import 'atelier3.dart';

class ProductListPageM3 extends StatelessWidget {
  const ProductListPageM3({Key? key}) : super(key: key);

  final List<Product> products = const [
    Product(
      name: 'iPhone 15',
      price: 999,
      image: 'https://picsum.photos/200/300',
      isNew: true,
      rating: 4.5,
    ),
    Product(
      name: 'Samsung Galaxy',
      price: 799,
      image: 'https://picsum.photos/201/300',
      isNew: false,
      rating: 4.2,
    ),
    Product(
      name: 'Google Pixel',
      price: 699,
      image: 'https://picsum.photos/202/300',
      isNew: true,
      rating: 4.7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos Produits'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(product.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (product.isNew)
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'NEW',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber.shade600,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(product.rating.toString()),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${product.price}€',
                            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} ajouté au panier'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}