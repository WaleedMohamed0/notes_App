
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:notes/NotesModel.dart';
import 'package:notes/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());

  static NotesCubit get(context) => BlocProvider.of(context);
  String date = DateFormat.yMMMd().format(DateTime.now());

  static late Database database;
  List<NotesModel> notesList = [];
  List<Color> noteColors = [Colors.white , HexColor('e5e5e5'),HexColor('ffe6c7'),HexColor('efffe5'),
  HexColor('ffcccb'),HexColor('cdffe6')];

  Future createDataBase() async {
    database = await openDatabase('notesa.db', version: 1,
        onCreate: (database, version) async {
      await database
          .execute(
              'CREATE TABLE NOTES (id INTEGER PRIMARY KEY , title text , description text)')
          .then((value) {
        print("Table Created");
        emit(NotesCreateDataBaseState());
      }).catchError((error) {
        print(error.toString());
        emit(NotesErrorState());
      });
    }, onOpen: (database) async {
      readNotes(database);
    });
  }

  Future insertToDataBase({
    required String title,
    required String desc,
  }) async {

    await database
        .rawInsert(
            'INSERT INTO NOTES (title , description) VALUES ("$title" , "$desc")')
        .then((value) {
      print('$value inserted Successfully');

      readNotes(database);
      emit(NotesInsertState());
    }).catchError((error) {
      print(error.toString());
      emit(NotesErrorState());
    });
  }

  Future readNotes(Database database) async {
    notesList = [];
    await database.rawQuery('SELECT * FROM NOTES').then((value) {
      for (var element in value) {
        notesList.add(NotesModel(
            id: element['id'] as int,
            title: element['title'] as String,
            description: element['description'] as String));
      }
      print(notesList.length);
      emit(NotesGetDataState());
    });
  }

  Future deleteDataBase({required int id}) async {
    await database.rawDelete('DELETE FROM NOTES where id = $id').then((value) {
      readNotes(database);
      emit(NotesDeleteState());
    });
  }

  void updateDataBase({
    required int id,
    required String description,
  }) async {
    database.rawUpdate('UPDATE NOTES SET description = ? where id = ?',
        ['$description', id])
        .then((value) {
      readNotes(database);
      emit(NotesUpdateState());
    });
  }
}
