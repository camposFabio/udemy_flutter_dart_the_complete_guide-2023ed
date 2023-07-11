import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.square,
                color: groceryItems[index].category.color,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                groceryItems[index].name,
              ),
              const Spacer(),
              Text(
                '${groceryItems[index].quantity}',
              )
            ],
          ),
        ),
      ),
    );
  }
}
