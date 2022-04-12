import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/cubit/cubit.dart';
import 'package:notes/home_screen.dart';
import 'package:notes/note_update.dart';

class NoteDetails extends StatelessWidget {
  final int index;

  NoteDetails({required this.index});

  @override
  Widget build(BuildContext context) {
    var cubit = NotesCubit.get(context);
    return Scaffold(
      backgroundColor:HexColor('304032'),
      appBar: AppBar(
        backgroundColor:HexColor('304032'),
        elevation: 0,
        actions:
        [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => NoteUpdate(index: index)));
          }, icon: const Icon(Icons.edit),),


          IconButton(onPressed: () {
            cubit.deleteDataBase(id: cubit.notesList[index].id);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false);
          }, icon: const Icon(Icons.delete),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
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
            const SizedBox(height: 20,),
            Text(cubit.notesList[index].description,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),),
          ],
        ),
      ),
    );
  }
}
