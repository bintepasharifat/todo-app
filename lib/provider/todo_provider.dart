import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoProvider extends ChangeNotifier{
  final List<TODOMODEL> _todoList=[];

  List<TODOMODEL> get allTODOList =>_todoList;

  void addToDoList(TODOMODEL todoModel){
    _todoList.add(todoModel) ;
    notifyListeners();

  }

  void todoStatusChange(TODOMODEL todoModel){
    final index = _todoList.indexOf(todoModel);
    _todoList[index].toggleCompleted();
    notifyListeners();
  }
  void removeToDoList(TODOMODEL todoModle){
    final index = _todoList.indexOf(todoModle);
    _todoList.removeAt(index);
     notifyListeners();

  }
}