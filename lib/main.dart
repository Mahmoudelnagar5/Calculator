import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/history_model.dart';
import 'views/calc_view.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryModelAdapter());
  await Hive.openBox<HistoryModel>('historyBox');
  runApp(
    const Calculator(),
  );
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const CalculatorView(),
    );
  }
}
