import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/data/widgets/new_item.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  //late Future<List<GroceryItem>> _loadedItems;

  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    //_loadedItems = _loadItems();
    _loadItems();
  }

  //Future<List<GroceryItem>> _loadItems() async {
  void _loadItems() async {
    final url = Uri.https(
        const String.fromEnvironment('FIREBASE_URL'), 'shopping-list.json');
    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        //throw Exception('Failed to fetch grocery items. Please try again later.');
        setState(() {
          _error = 'Failed to fetch data. Please try again later.';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        //return [];
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);

      final List<GroceryItem> loadItemsList = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
              (catItem) => catItem.value.title == item.value['category'],
            )
            .value;

        loadItemsList.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }
      setState(() {
        _groceryItems = loadItemsList;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Somenthing went wrong. Please try again';
      });
    }
    //return loadItemsList;
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(const String.fromEnvironment('FIREBASE_URL'),
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      // Optional error message
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          direction: DismissDirection.endToStart,
          background: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
      // body: FutureBuilder(
      //   future: _loadedItems,
      //   builder: ((context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Text(snapshot.error.toString()));
      //     }
      //     if (snapshot.data!.isEmpty) {
      //       return const Center(child: Text('No items added yet.'));
      //     }
      //     return ListView.builder(
      //       itemCount: snapshot.data!.length,
      //       itemBuilder: (ctx, index) => Dismissible(
      //         key: ValueKey(snapshot.data![index].id),
      //         onDismissed: (direction) {
      //           _removeItem(snapshot.data![index]);
      //         },
      //         direction: DismissDirection.endToStart,
      //         background: const Padding(
      //           padding: EdgeInsets.only(right: 10),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Icon(
      //                 Icons.delete,
      //                 color: Colors.red,
      //               ),
      //             ],
      //           ),
      //         ),
      //         child: ListTile(
      //           title: Text(snapshot.data![index].name),
      //           leading: Container(
      //             width: 24,
      //             height: 24,
      //             color: snapshot.data![index].category.color,
      //           ),
      //           trailing: Text(
      //             snapshot.data![index].quantity.toString(),
      //           ),
      //         ),
      //       ),
      //     );
      //   }),
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Row(
      //     children: [
      //       Icon(
      //         Icons.square,
      //         color: groceryItems[index].category.color,
      //       ),
      //       const SizedBox(
      //         width: 10,
      //       ),
      //       Text(
      //         groceryItems[index].name,
      //       ),
      //       Spacer(),
      //       Text(
      //         '${groceryItems[index].quantity}',
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
