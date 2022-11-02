import 'package:flutter/material.dart';
import 'package:schedumol_app/widgets/todo_item.dart';
import 'package:schedumol_app/model/twodo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _toController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
        appBar: _buildAppBar(),

        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 19),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:50,bottom: 1,),
                          
                        ),

                        for (ToDo todoo in _foundToDo)
                          TodoItem(
                            todo: todoo,
                            onToDoChanged: _handleToDoChange,
                            onDeletedItem: _deletedToDoItem,

                          ),

                      ],
                    ),
                  )

                ],
              ),


            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0,0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                      ),],
                        borderRadius: BorderRadius.circular(10),
                      ),
              child: TextField(
                controller: _toController,
                decoration: InputDecoration(
                  hintText: '추가할 단어를 입력',
                  border: InputBorder.none
                ),
              ),
                ),
              ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text('+',style: TextStyle(fontSize: 40,),),
                    onPressed: () {
                      _addToDoItem(_toController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(60,60),
                      elevation: 10,
                    ),
                  ),
                )
              ],),
            )
          ],
        ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });

  }

  void _deletedToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _toController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase()))
          .toList();

    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value) ,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color:Colors.black,
            size:20,
          ),
          prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25
          ),
          border: InputBorder.none,
          hintText:'단어 찾기',
          hintStyle:TextStyle(color:Colors.green),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
          Icon(
            Icons.wordpress_sharp,
            color: Colors.black38,
            size: 50,
          ),
          Container(
            child:
            Text("단어장",style: TextStyle(fontSize:35,fontWeight: FontWeight.bold),),
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:Image.asset('8650a783a636b6efccee3fa7c9455630.jpg'),
            ),
          ),
        ]),
      );
  }
}
