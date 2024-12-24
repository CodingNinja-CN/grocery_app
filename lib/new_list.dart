import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({super.key});

  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  final TextEditingController _controller = TextEditingController();

  // Save the new list to SharedPreferences
  _saveList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> groceryLists = prefs.getStringList('groceryLists') ?? [];
    groceryLists.add(_controller.text);
    await prefs.setStringList('groceryLists', groceryLists);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('New Grocery List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter List Title',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveList,
                child: const Text('Save List'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
