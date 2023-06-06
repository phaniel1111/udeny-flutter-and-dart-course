import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItem();
  }
  void _loadItem() async {
    final url = Uri.https('shopping-flutter-e6d08-default-rtdb.asia-southeast1.firebasedatabase.app','shopping-list.json');
    final rp = await http.get(url);
    if(rp.statusCode >= 400) {
      setState(() {
        _error = 'Failed to fetch data. Please try again later';
      });
      return;
    }
    if(rp.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final Map<String,dynamic> listData = json.decode(rp.body);
    final List<GroceryItem> loadedItemList = [];
    for(final i in listData.entries){
      final cat = categories.entries.firstWhere((e) => e.value.title == i.value['category']).value;
      loadedItemList.add(GroceryItem(id: i.key, name: i.value['name'], quantity: i.value['quantity'], category: cat));
    }
    setState(() {
      _groceryItems = loadedItemList;
      _isLoading = false;
    });

  }

  void addItem() async {
    final item = await Navigator.push<GroceryItem>(
      context,
      MaterialPageRoute(builder: (context) => const NewItem()),
    );
    if(item == null) return;
    setState(() {
      _groceryItems.add(item);
    });
  }
  void _deleteItem(GroceryItem item) async{
      final idx = _groceryItems.indexOf(item);
      setState(() {
        _groceryItems.remove(item);
      });
      final url = Uri.https('shopping-flutter-e6d08-default-rtdb.asia-southeast1.firebasedatabase.app','shopping-list/${item.id}.json');
      final rp = await http.delete(url);

      if(rp.statusCode >= 400) {
        setState(() {
          _groceryItems.insert(idx, item);
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text("You don't have any item yet"),);

    if(_isLoading){
      content = const Center(child: CircularProgressIndicator(),);
    }
    if(_error != null){
      content = Center(child: Text(_error!),);
    }
    if (_groceryItems.isNotEmpty){
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction){_deleteItem(_groceryItems[index]);},
          key: ValueKey(_groceryItems[index].id),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}