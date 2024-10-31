import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math_expressions/math_expressions.dart';

import '../models/history_model.dart';
import '../widgets/custom_button_item.dart';
import '../widgets/custom_input_text.dart';
import '../widgets/custom_output_text.dart';
import '../widgets/show_history.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

final List<String> buttons = [
  'AC',
  '⌫',
  '%',
  '÷',
  '7',
  '8',
  '9',
  'x',
  '4',
  '5',
  '6',
  '-',
  '1',
  '2',
  '3',
  '+',
  '0',
  '.',
  'Ans',
  '='
];

class _CalculatorViewState extends State<CalculatorView> {
  String input = '';
  String output = '';
  Key inputKey = UniqueKey(); // Unique key to trigger animation
  bool showHistory =
      false; // Track whether to show history or calculator buttons
  List<HistoryModel> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    final box = Hive.box<HistoryModel>('historyBox');
    setState(() {
      history = box.values.toList();
    });
  }

  void evaluateExpression() {
    try {
      String finalInput = input.replaceAll('x', '*').replaceAll('÷', '/');
      Parser parser = Parser();
      Expression expression = parser.parse(finalInput);

      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);

      setState(() {
        output = eval.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        output = '= $output';
      });

      HistoryModel historyItem = HistoryModel(input: input, output: output);
      final box = Hive.box<HistoryModel>('historyBox');
      box.add(historyItem);
      setState(() {
        history = box.values.toList();
      });
    } catch (e) {
      setState(
        () {
          output = 'Error';
        },
      );
    }
  }

  void clearHistory() async {
    final box = Hive.box<HistoryModel>('historyBox');
    await box.clear();
    setState(() {
      history.clear();
    });
  }

  retHistory(String value) {
    setState(() {
      input += value.replaceAll('= ', '');
    });
  }

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        input = '';
        output = '';
      } else if (value == '⌫') {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
      } else if (value == '=') {
        if (showHistory) {
          setState(() {
            showHistory = false;
          });
        }
        evaluateExpression();
      } else if (value == 'Ans') {
        if (output.isNotEmpty && output != 'Error') {
          setState(
            () {
              input = output.replaceAll('=', '');
              output = '';
              inputKey = UniqueKey(); // Change key to trigger animation
            },
          );
        }
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            CustomInputText(
              inputKey: inputKey,
              input: input,
            ),
            CustomOutputText(output: output),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      showHistory = !showHistory;
                    });
                  },
                  icon: const Icon(
                    Icons.history,
                  ),
                  color: Colors.grey.shade300,
                ),
                const Spacer(),
                if (showHistory)
                  TextButton(
                    onPressed: () => onButtonPressed('⌫'),
                    child: const Text(
                      '⌫',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
              height: 5,
              thickness: .3,
            ),
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.62,
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    itemCount: buttons.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      return CustomButtonItem(
                        onTap: () => onButtonPressed(buttons[index]),
                        text: buttons[index],
                        color: index % 4 == 3 || index == buttons.length - 1
                            ? Colors.orangeAccent
                            : (index == 0 || index == 1 || index == 2
                                ? Colors.grey[50]
                                : Colors.grey.shade800),
                        textColor: index == 0 || index == 1 || index == 2
                            ? Colors.black
                            : Colors.white,
                      );
                    },
                  ),
                ),
                if (showHistory)
                  ShowHistory(
                    historyList: history,
                    clearHistory: clearHistory,
                    onHistoryTap: retHistory,
                  ),
                // Show history when showHistory is true
              ],
            ),
          ],
        ),
      ),
    );
  }
}
