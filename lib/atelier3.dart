import 'package:flutter/material.dart';


class Product {
  final String name;
  final double price;
  final String image;
  final double rating;
  final bool isNew;

  const Product({
    required this.name,
    required this.price,
    required this.image,
    this.rating = 0.0,
    this.isNew = false,
  });
}

class ProductDetailPage extends StatefulWidget {
  final Product product;
  
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ValueNotifier<int> _quantity = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
         
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.product.image,
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],
          ),
          
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name,
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.product.price}€',
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                   
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(widget.product.rating.toString()),
                        const SizedBox(width: 8),
                        Text('(128 avis)', 
                            style: TextStyle(color: colorScheme.secondary)),
                      ],
                    ),
                    const SizedBox(height: 24),
                  
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Découvrez le ${widget.product.name}, un produit haute performance conçu pour répondre à tous vos besoins. Design élégant et fonctionnalités avancées.',
                      style: TextStyle(
                        color: colorScheme.secondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                   
                    Text(
                      'Quantité',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ValueListenableBuilder<int>(
                      valueListenable: _quantity,
                      builder: (context, quantity, child) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: colorScheme.primary),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: quantity > 1 ? () {
                                  _quantity.value--;
                                } : null,
                              ),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  quantity.toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _quantity.value++;
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 100), 
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.primary.withOpacity(0.2))),
        ),
        child: Row(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _quantity,
              builder: (context, quantity, child) {
                return Text(
                  '${(widget.product.price * quantity).toStringAsFixed(2)}€',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                 
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.product.name} ajouté au panier'),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Ajouter au panier'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    home: const ProductDetailPage(
      product: Product(
        name: 'Smartphone XYZ',
        price: 599.99,
        image: 'https://picsum.photos/500/300',
        rating: 4.5,
      ),
    ),
  ));
}