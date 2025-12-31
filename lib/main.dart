import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtorrent/Screens/bloc/mtorrent_bloc.dart';
import 'package:mtorrent/Screens/home.dart';
// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocProvider(
      create: (context) => MtorrentBloc(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Mtorrent',
        home: Home(),
      ),
    );
  }
}
