import 'package:flutter/material.dart';
import 'package:grocery_app/new_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _groceryLists = [];

  @override
  void initState() {
    super.initState();
    _loadGroceryLists();
  }

  // Load grocery list titles from SharedPreferences
  _loadGroceryLists() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _groceryLists = prefs.getStringList('groceryLists') ?? [];
    });
  }

  // Delete a grocery list
  _deleteList(int index) async {
    final prefs = await SharedPreferences.getInstance();
    _groceryLists.removeAt(index);
    await prefs.setStringList('groceryLists', _groceryLists);
    setState(() {});
  }

  // Navigate to the Item Page for a specific list
  _navigateToItemPage(String listTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemPage(listTitle: listTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Grocery Lists',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          actions: [
            IconButton(
              icon: const Icon(Icons.add,color: Colors.white,),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewListPage(),
                ),
              ).then((_) => _loadGroceryLists()),
            ),
          ],
        ),
        body: _groceryLists.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://img.freepik.com/premium-vector/full-shopping-cart-with-store-groceries-isolated-trolley-full-food_316839-489.jpg',
                width: 300,
              ),
              const SizedBox(height: 20),
              const Text(
                'Add a new list!',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        )
            : ListView.builder(
          itemCount: _groceryLists.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: Text(_groceryLists[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit,color: Colors.blueGrey,),
                      onPressed: () => _navigateToItemPage(_groceryLists[index]),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,color: Colors.red,),
                      onPressed: () => _deleteList(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
