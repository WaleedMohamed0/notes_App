import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/cubit/cubit.dart';
import 'package:notes/home_screen.dart';

class NoteUpdate extends StatelessWidget {
  final int index;

   NoteUpdate({required this.index});

  @override
  Widget build(BuildContext context) {
    var cubit = NotesCubit.get(context);
    TextEditingController descController =
        TextEditingController(text: cubit.notesList[index].description,);
    return Scaffold(
      backgroundColor:HexColor('304032'),
      appBar: AppBar(
        backgroundColor:HexColor('304032'),
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 11, bottom: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TextButton(
              onPressed: () {
                cubit.updateDataBase(
                    id: cubit.notesList[index].id,
                    description: descController.text);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false);
              },
              child: const Text(
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
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Text(cubit.notesList[index].title,
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4,),
            Text(
              cubit.date,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey[300]),
            ),
            const SizedBox(height: 8,),
            TextFormField(
              controller: descController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(

                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
