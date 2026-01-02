import 'package:flutter/material.dart';

import '../../../constants/text_style.dart';
class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.amber.shade600,
      ),
      dividerColor: Colors.black12,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(8.0),
      tabs: [
        Tab(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Scan", style: textStyle(fontSize: 22)),
          ),
        ),
        Tab(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Create", style: textStyle(fontSize: 22)),
          ),
        ),
      ],
    );
  }
}
