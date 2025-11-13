import 'package:flutter/material.dart';


class Product {
  final String name;
  final double price;
  final String image;
  final bool isNew;
  final double rating;
  final String description;
  final Map<String, String> specifications;

  const Product(
    this.name,
    this.price,
    this.image, {
    this.isNew = false,
    this.rating = 0.0,
    required this.description,
    required this.specifications,
  });
}


class ProductListPageM3 extends StatefulWidget {
  const ProductListPageM3({Key? key}) : super(key: key);

  @override
  State<ProductListPageM3> createState() => _ProductListPageM3State();
}

class _ProductListPageM3State extends State<ProductListPageM3> {
 
  final List<Product> _products = const [
    Product(
      'iPhone 15',
      999,
      'images/iphone15.png',
      isNew: true,
      rating: 4.5,
      description:
          'Découvrez le iPhone 15, un produit haute performance conçu pour répondre à tous vos besoins. Design élégant et fonctionnalités avancées pour une expérience exceptionnelle.',
      specifications: {
        'Écran': '6.1 pouces Super Retina XDR',
        'Processeur': 'A16 Bionic',
        'Mémoire': '128 GB',
        'Batterie': "Jusqu'à 20h de vidéo",
      },
    ),
    Product(
      'Samsung Galaxy',
      799,
      'images/Galaxy S23.png',
      isNew: false,
      rating: 4.2,
      description: 'Le dernier Samsung Galaxy avec des fonctionnalités incroyables.',
      specifications: {'Écran': 'AMOLED 6.5"', 'Caméra': '50 MP', 'Batterie': '5000 mAh'},
    ),
    Product(
      'Google Pixel',
      699,
      'images/1.png',
      isNew: true,
      rating: 4.7,
      description: 'Un téléphone intelligent et rapide avec la meilleure caméra logicielle.',
      specifications: {'Écran': 'OLED 6.2"', 'Puce': 'Tensor G3', 'Sécurité': 'Titan M2'},
    ),
  ];


  final Map<int, int> _cart = {};

  int get _cartItemCount => _cart.values.fold(0, (a, b) => a + b);

  double get _cartTotalPrice {
    double total = 0;
    _cart.forEach((idx, qty) {
      total += _products[idx].price * qty;
    });
    return total;
  }

  void _addToCart(int index) {
    setState(() {
      _cart[index] = (_cart[index] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${_products[index].name} ajouté au panier')));
  }

  void _showCartSummary() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('Récapitulatif Panier', style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Articles: ${_cartItemCount}'),
              const SizedBox(height: 4),
              Text('Total: ${_cartTotalPrice.toStringAsFixed(2)}€'),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fermer'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos Produits'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: _showCartSummary,
                  icon: Icon(Icons.shopping_cart, color: colorScheme.onSurface),
                ),
                if (_cartItemCount > 0)
                  Positioned(
                    right: 6,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        '$_cartItemCount',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: _products[index], onAdd: () => _addToCart(index));
        },
      ),
    );
  }
}


class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onAdd;
  const ProductCard({Key? key, required this.product, this.onAdd}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    
    _isExpanded = false;
    _controller.value = 0.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final product = widget.product;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
               
                Stack(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (product.isNew)
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
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
                        style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(product.rating.toString()),
                          const SizedBox(width: 12),
                          Text(
                            '${product.price.toStringAsFixed(0)}€',
                            style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary) ?? TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                
                IconButton(
                  onPressed: () {
                    
                    if (widget.onAdd != null) {
                      widget.onAdd!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} ajouté au panier')));
                    }
                  },
                  icon: Icon(Icons.shopping_cart, color: colorScheme.primary),
                ),
                
             
                IconButton(
                  onPressed: _toggleExpanded,
                  icon: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      
                      return Icon(
                        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: colorScheme.onSurface,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          

          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: _animation,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1, thickness: 0.5),
                  const SizedBox(height: 12),

                  
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 16),

                  
                  Text(
                    'Spécifications',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  
                 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: product.specifications.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100, 
                              child: Text(
                                entry.key,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}