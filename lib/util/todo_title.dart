import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTitle extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;


  TodoTitle({
    super.key, 
    required this.taskName, 
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: const Color.fromRGBO(255, 104, 104, 1),
              borderRadius: BorderRadius.circular(10),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(254, 187, 204, 1),
            borderRadius: BorderRadius.circular(10),
        
          ),
        
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted, 
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style:  TextStyle(
                  fontSize: 18,
                  decoration:  taskCompleted ? TextDecoration.lineThrough: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}