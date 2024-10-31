import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/history_model.dart';
import 'custom_history_item.dart';

class ListViewResults extends StatelessWidget {
  final List<HistoryModel> historyList;
  final VoidCallback clearHistory;
  final Function(String) onHistoryTap;

  const ListViewResults({
    super.key,
    required this.historyList,
    required this.clearHistory,
    required this.onHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              return CustomHistoryItem(
                history: historyList[index],
                onTap: () => onHistoryTap(historyList[index].output),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 7.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * .7, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: clearHistory,
            child: Text(
              'Remove All',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
