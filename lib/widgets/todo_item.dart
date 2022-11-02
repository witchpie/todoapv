import 'package:flutter/material.dart';
import 'package:schedumol_app/model/twodo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeletedItem;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeletedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20
      ),
      child: ListTile(

        onTap: () {
          //print('Click on Todo Item.');
          onToDoChanged(todo);
        },

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),

        tileColor: todo.isDone? Colors.blueGrey[300]: Colors.white,

        leading: Icon(
          todo.isDone?   Icons.check_box: Icons.check_box_outline_blank,
          color:Colors.blue,),
        title: Text(
            todo.todoText! ,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,

            ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 2),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),

            onPressed: () {
              //print('clicked on delete icon');
              onDeletedItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
