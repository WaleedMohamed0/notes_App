import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:notes/add_note_screen.dart';
import 'package:notes/cubit/cubit.dart';
import 'package:notes/cubit/states.dart';
import 'package:notes/note_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = NotesCubit.get(context);
    return Scaffold(
      backgroundColor: HexColor('304032'),
      appBar: AppBar(
        elevation: 8,
        backgroundColor: HexColor('304032'),
        title: const Padding(
          padding: EdgeInsets.only(left: 14.0),
          child: Text(
            'Notes',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.6,
            ),
          ),
        ),
      ),
      body:
      // Center(
      //   child: Text(
      //     'You Don\'t have any notes yet, Create One',
      //     style: const TextStyle(
      //       color: Colors.white,
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // )
      Padding(
              padding: const EdgeInsets.all(25.0),
              child: BlocConsumer<NotesCubit, NotesStates>(
                listener: (context, state) {},
                builder: (context, state) =>
                  cubit.notesList.length >0 ?
                   GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(
                      cubit.notesList.length,
                          (index) =>
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NoteDetails(
                                                index: index,
                                              )));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  width: 160,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: cubit.noteColors[index %
                                        cubit.noteColors.length],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        cubit.date,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.black87),
                                      ),
                                      Text(
                                        cubit.notesList[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ),
                  )
                      :
                  const Center(
                    child: Text(
                      'You Don\'t have any notes yet, Create One',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                )),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const addNote()));
        },
        child: Icon(
          Icons.note_add,
          size: 35,
          color: HexColor('304032'),
        ),
      ),
    );
  }
}
