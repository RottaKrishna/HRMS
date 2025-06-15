import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestState();
}

//The below line means _RequestState manages the state of the Requests class
//State<T> is a generic class in Flutter
class _RequestState extends State<Requests> {
  @override
  Widget build(context) {
    return Container(child: Text('Requests Page'));
  }
}
