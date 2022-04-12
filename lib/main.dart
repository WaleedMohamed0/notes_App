import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/add_note_screen.dart';
import 'package:notes/cubit/cubit.dart';
import 'package:notes/home_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit()..createDataBase(),
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}