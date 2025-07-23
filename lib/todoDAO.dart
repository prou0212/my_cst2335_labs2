import 'package:floor/floor.dart';
import 'ToDoItem.dart';
import 'dart:async';

@dao
abstract class TodoDAO {
  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> findAllItems();

  @Query('DELETE FROM ToDoItem WHERE id = :id')
  Future<void> delete(int id);

  @insert
  Future<void> add(ToDoItem item);
}