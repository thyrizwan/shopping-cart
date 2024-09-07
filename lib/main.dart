import 'package:flutter/material.dart';
import 'package:shopingcart/class/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartScreen(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          titleTextStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Colors.pink,
      //     titleTextStyle: TextStyle(
      //       fontSize: 18,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
    );
  }
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<String, Item> itemMap = {
    'item1': Item(
        title: 'Dennis Casual Shirt',
        color: 'Black',
        size: 'M',
        price: 3000.0,
        imageUrl:
            'https://m.media-amazon.com/images/I/51yIybqYFTL._SX679_.jpghttps://m.media-amazon.com/images/I/51yIybqYFTL._SX679_.jpg'),
    'item2': Item(
        title: 'Thomas Scott Jeans',
        color: 'Blue',
        size: 'L',
        price: 4000.0,
        imageUrl:
            'https://m.media-amazon.com/images/I/61u0LsT7qdL._SY879_.jpg'),
    'item3': Item(
        title: 'Nike Mens Sneakers',
        color: 'Red',
        size: 'S',
        price: 6000.0,
        imageUrl:
            'https://m.media-amazon.com/images/I/51NDAxr0ggL._SX695_.jpg'),
  };

  // Method to update quantity and trigger UI rebuild
  void updateQuantity(String key, int newQuantity) {
    setState(() {
      itemMap[key]!.quantity = newQuantity;
    });
  }

  // Calculate total price for all items in the cart
  double getTotalAmount() {
    double total = 0;
    itemMap.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // List of items in the cart
          Expanded(
            child: ListView.builder(
              itemCount: itemMap.length,
              itemBuilder: (context, index) {
                var keys = itemMap.keys.toList();
                var currentItem = itemMap[keys[index]]!;

                return Card(
                  // color: Colors.pink.shade50,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImageContainer(currentItem),
                        const SizedBox(width: 10),
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Delete Icon Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTitle(currentItem),
                                  Icon(Icons.more_vert,
                                      color: Colors.grey.shade500),
                                ],
                              ),
                              const SizedBox(height: 5),

                              // Color and Size Info
                              Row(
                                children: [
                                  _buildColorPart(currentItem),
                                  const SizedBox(width: 15),
                                  _buildSizePart(currentItem),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Quantity and Price Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Quantity Counter
                                  Row(
                                    children: [
                                      _buildDecreaseMethod(
                                          currentItem, keys, index),
                                      const SizedBox(width: 8),
                                      Text('${currentItem.quantity}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 8),
                                      _buildIncreaseMethod(
                                          keys, index, currentItem)
                                    ],
                                  ),
                                  // Price
                                  Text(
                                    '₹${(currentItem.price * currentItem.quantity).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Total Amount and Checkout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${getTotalAmount().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: _buildCheckoutButton(context),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final myMessage = SnackBar(
          behavior: SnackBarBehavior.floating,
          content: const Text(
            'Order Successfully placed',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.pink.shade50,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(myMessage);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink.shade700, // background color
        foregroundColor: Colors.white, // text color
        minimumSize: const Size(double.infinity, 50), // width and height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        'Place Order (₹${getTotalAmount().toStringAsFixed(2)})',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSizePart(Item currentItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Size: "),
        Text(
          currentItem.size,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildColorPart(Item currentItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Color: "),
        Text(
          currentItem.color,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildIncreaseMethod(
      List<String> keys, int index, Item currentItem) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.green.shade700, // Button background color
        borderRadius: BorderRadius.circular(5), // Rounded corners
      ),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white, size: 15,),
          onPressed: () {
            updateQuantity(keys[index], currentItem.quantity + 1);
          },
        ),
      ),
    );
  }

  Widget _buildDecreaseMethod(
      Item currentItem, List<String> keys, int index) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.red.shade700, // Button background color
        borderRadius: BorderRadius.circular(5), // Rounded corners
      ),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.remove, color: Colors.white, size: 15,),
          onPressed: () {
            if (currentItem.quantity > 1) {
              updateQuantity(keys[index], currentItem.quantity - 1);
            }
          },
        ),
      ),
    );
  }

  Widget _buildTitle(Item currentItem) {
    return Expanded(
      child: Text(
        currentItem.title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }

  Widget _buildImageContainer(Item currentItem) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(currentItem.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Cart',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
