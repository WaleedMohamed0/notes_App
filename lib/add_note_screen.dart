import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/cubit/cubit.dart';
import 'package:notes/home_screen.dart';

class addNote extends StatelessWidget {
  const addNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = NotesCubit.get(context);
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    return Scaffold(
      backgroundColor:HexColor('304032'),
      appBar: AppBar(
        backgroundColor:HexColor('304032'),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 35,
            )),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: 11, bottom: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),

            child: TextButton(
              onPressed: () {
                cubit.insertToDataBase(
                    title: titleController.text, desc: descController.text);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
                labelText: 'Title',
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: descController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
                labelText: 'Type something...',
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
