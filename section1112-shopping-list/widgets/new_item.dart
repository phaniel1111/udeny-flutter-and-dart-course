import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopping_list/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.other!];
  var _isSending = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https('shopping-flutter-e6d08-default-rtdb.asia-southeast1.firebasedatabase.app','shopping-list.json');
      final rp = await http.post(url, headers: {
        'Content-Type': 'application/json',
      }, body: json.encode({
        'name': _enteredName,
        'quantity': _enteredQuantity,
        'category': _selectedCategory!.title,
      }));
      final Map<String,dynamic> rpData = json.decode(rp.body);
      if(!context.mounted) return;
      Navigator.pop(
          context,
          GroceryItem(
            id: rpData['name'],
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _selectedCategory!,
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('name'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must be a valid name';
                  }
                  return null;
                },
                onSaved: (v) {
                  _enteredName = v!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Quantity"),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid number';
                        }
                        return null;
                      },
                      initialValue: _enteredQuantity.toString(),
                      onSaved: (v) {
                        _enteredQuantity = int.parse(v!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for (final i in categories.entries)
                          DropdownMenuItem(
                            value: i.value,
                            child: Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  color: i.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(i.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          _selectedCategory = v!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: _isSending ? null : () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Reset')),
                  ElevatedButton(
                      onPressed: _isSending ? null : _saveItem, child: const Text('Submit')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
