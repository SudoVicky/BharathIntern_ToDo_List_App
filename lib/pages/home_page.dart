import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_app/data/datatbase.dart';
import 'package:todo_list_app/util/dialog_box.dart';
import 'package:todo_list_app/util/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('myBox');
  final _controller = TextEditingController();

  TodoDatabase db = TodoDatabase();

  @override
  void initState() {

    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  void saveTask(){
    setState(() {
        db.todoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    _controller.clear();
    db.updateDatabase();
  }
  void cancelTask(){
    Navigator.of(context).pop();
    _controller.clear();
  }
    
  void createNewTask(){
    showDialog(
      context: context, 
      builder:(context) {
        return DialogBox(
          controller: _controller,
          onSave: saveTask,
          onCancel: cancelTask,
        );
      },

    );

    
  }
  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(255, 238, 204, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(254, 187, 204, 1),
        title: const Text(
          "To Do",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTitle(
            taskName: db.todoList[index][0], 
            taskCompleted: db.todoList[index][1], 
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: const Color.fromRGBO(254, 187, 204, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}