import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add todo List"),
            content: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: "write to do item"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }
                    context.read<TodoProvider>().addToDoList(new TODOMODEL(
                        title: _textController.text, isCompleted: false));

                    _textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff622CA7),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(41),
                      bottomLeft: Radius.circular(41))),
              child: Center(
                  child: Text(
                "To Do List",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemBuilder: (context, itemIndex) {
                return ListTile(
                  onTap: () {
                    provider.todoStatusChange(provider.allTODOList[itemIndex]);
                  },
                  leading: MSHCheckbox(
                      size: 30,
                      value: provider.allTODOList[itemIndex].isCompleted,
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                          checkedColor: Colors.blue),
                      style: MSHCheckboxStyle.stroke,
                      onChanged: (selected) {
                        provider
                            .todoStatusChange(provider.allTODOList[itemIndex]);
                      }),
                  title: Text(
                    provider.allTODOList[itemIndex].title,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        decoration:
                            provider.allTODOList[itemIndex].isCompleted == true
                                ? TextDecoration.lineThrough
                                : null),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      provider.removeToDoList(provider.allTODOList[itemIndex]);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
              itemCount: provider.allTODOList.length,
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff622CA7),
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
