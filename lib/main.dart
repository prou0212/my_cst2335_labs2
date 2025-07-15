import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:my_cst2335_labs/ToDoItem.dart';
import 'package:my_cst2335_labs/database.dart';
import 'package:my_cst2335_labs/todoDAO.dart';

import 'ToDoItem.dart';

void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lab 7'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? enterItem;
  String? enterQuantity;
  TextEditingController _controllerItem = TextEditingController();
  TextEditingController _controllerQuantity = TextEditingController();

  late AppDatabase database;
  late TodoDAO _dao;
  List<ToDoItem> items = [];
  bool isLoading = true;

  Future<void> _initDatabase() async {
    try {
      database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      _dao = database.todoDao;
      // await _dao.add(
      //   ToDoItem(0, 'Apple', '10'),
      // );
      // await _dao.add(
      //   ToDoItem(1, 'Orange', '20'),
      // );
      // await _loadItems();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Database initialization error: $e");
      setState(() {
        isLoading = false;
      });
    }
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final loadedItems = await database.todoDao.findAllItems();

      setState(() {
        items = loadedItems;
      });
    } catch (e) {
      print('Error loading items: $e');
    }
  }

  Future<void> _addItems(String name, String quantity) async {
    try {
      final newID = DateTime.now().millisecondsSinceEpoch;
      final newItem = ToDoItem(newID, name, quantity);

      await database.todoDao.add(newItem);
      await _loadItems();
    } catch (e) {
      print('Error adding item: $e');
    }
  }

  Future<void> _deleteItems(int id) async {
    try {
      await database.todoDao.delete(id);
      await _loadItems();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerItem = TextEditingController();
    _controllerQuantity = TextEditingController();
    Future.delayed(Duration.zero, () async {
      await _initDatabase();
    });
  }

  @override
  void dispose() {
    _controllerItem.dispose();
    _controllerQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Please enter the fields below",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controllerItem,
                    decoration: InputDecoration(
                      hintText: "Type the item here",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controllerQuantity,
                    decoration: InputDecoration(
                      hintText: "Type the quantity here",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (_controllerItem.text.isNotEmpty &&
                        _controllerQuantity.text.isNotEmpty) {
                      showDialog<String>(
                        context: context,
                        builder:
                            (BuildContext context) => AlertDialog(
                              title: const Text("Add Items?"),
                              content: const Text(
                                "Do you want to add any items items from the list?",
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    _controllerItem.clear();
                                    _controllerQuantity.clear();
                                  },
                                  child: const Text('NO'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await _addItems(
                                      _controllerItem.text,
                                      _controllerQuantity.text,
                                    );

                                    _controllerItem.clear();
                                    _controllerQuantity.clear();
                                  },
                                  child: const Text("YES"),
                                  //TODO: Selecting "No" from the AlertDialog does not remove the item from the list.
                                ),
                              ],
                            ),
                      );
                    }
                  },
                  child: const Text("Click Me"),
                ),
              ],
            ),
            Expanded(child: listPage()),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget listPage() {
    return Column(
      children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, rowNum) {
                final item = items[rowNum];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text("Details about Item"),
                            content: Text(
                              "Item: {$items.name}\nQuantity: ${item.quantity}",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"),
                              ),
                            ],
                          ),
                    );
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text("Delete Item"),
                            content: Text(
                              "Would you like to delete then item you selected?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await _deleteItems(item.id);
                                },
                                child: const Text('YES'),
                              ),

                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: const Text("NO"),
                              ),
                            ],
                          ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${rowNum + 1}: "),
                      Expanded(
                        child: Text("${item.name} (Qty: ${item.quantity})"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
