// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/counter_bloc.dart';
import 'data/counter_repository.dart';
import 'ui/counter_page.dart';

void main() {
  final repo = CounterRepository();

  runApp(
    BlocProvider(
      create: (_) => CounterBloc(repo),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CounterPage(),
      ),
    ),
  );
}
