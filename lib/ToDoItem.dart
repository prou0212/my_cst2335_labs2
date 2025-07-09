import 'package:floor/floor.dart';

@entity
class ToDoItem {

  @primaryKey
  final int id;

  final String name;
  final String quantity;

  static int ID = 1;

  ToDoItem(this.id, this.name, this.quantity) {
    
    if(id > ID) {
      ID = id + 1;
    }

  }
}