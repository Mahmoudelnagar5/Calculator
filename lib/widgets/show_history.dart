import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../models/history_model.dart';
import 'list_view_results.dart';

class ShowHistory extends StatelessWidget {
  const ShowHistory({
    super.key,
    required this.historyList,
    required this.clearHistory,
    required this.onHistoryTap,
  });
  final List<HistoryModel> historyList;
  final VoidCallback clearHistory;
  final Function(String) onHistoryTap;
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade900,
        ),
        width: MediaQuery.of(context).size.width * .72,
        height: MediaQuery.of(context).size.height * 0.56,
        child: ListViewResults(
          historyList: historyList,
          clearHistory: clearHistory,
          onHistoryTap: onHistoryTap,
        ),
      ),
    );
  }
}
