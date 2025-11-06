import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/counter_bloc.dart';
import 'data/counter_repository.dart';
import 'ui/counter_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // cần thiết để dùng SharedPreferences

  final repo = CounterRepository();
  await repo.loadFromStorage(); // tải dữ liệu lưu trước đó

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
