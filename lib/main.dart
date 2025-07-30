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
      home: const MyHomePage(title: 'Lab 8'),
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

  ToDoItem? selectedItem;
  Widget reactiveLayout() {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    print("Screen size: ${width}x${height}, selectedItem: ${selectedItem?.name}");

    if ((width > height) && (width > 720)) {
      return Row(
        children: [
          Expanded(flex: 1, child: listPage()),
          VerticalDivider(width: 1),
          Expanded(flex: 2, child: detailsPage()),
        ],
      );
    } else {
      print("Using phone layout");
      if (selectedItem == null) {
        return listPage();
      } else {
        return detailsPage();
      }
    }
  }

  Widget detailsPage() {
    if (selectedItem == null) return Center(child: Text("No item selected"));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Item: ${selectedItem!.name}", style: TextStyle(fontSize: 18)),
          Text("Quantity: ${selectedItem!.quantity}", style: TextStyle(fontSize: 18)),
          Text("ID: ${selectedItem!.id}", style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _deleteItems(selectedItem!.id);
                  setState(() {
                    selectedItem = null;
                  });
                },
                child: Text("Delete"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedItem = null;
                  });
                },
                child: Text("Close"),
              ),
            ],
          ),
        ],
      ),
    );
  }


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
       body: reactiveLayout(),

    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget listPage() {
    return Column(
      children: [
        Text("Please enter the fields below", style: TextStyle(fontSize: 20)),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controllerItem,
                decoration: InputDecoration(
                    hintText: "Type the item here"),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _controllerQuantity,
                decoration: InputDecoration(hintText: "Type the quantity here"),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_controllerItem.text.isNotEmpty &&
                    _controllerQuantity.text.isNotEmpty) {
                  await _addItems(
                    _controllerItem.text,
                    _controllerQuantity.text,
                  );
                  _controllerItem.clear();
                  _controllerQuantity.clear();
                }
              },
              child: Text("Add Item"),
            ),
          ],
        ),
        Text("Tap an item to view details:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, rowNum) {
              final item = items[rowNum];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItem = item;
                  });
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

