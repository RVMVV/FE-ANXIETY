// ignore_for_file: unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:screening_app/utils/constant_finals.dart';

import 'widgets/history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Screening',
          style: Styles.urbanistBold.copyWith(color: textColor, fontSize: 26),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              HistoryCard(month: 'JAN', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'FEB', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'MAR', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'APR', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'MAY', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'JUN', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'JUL', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'AUG', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'SEP', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'OKT', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'NOV', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'DEC', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'JAN', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'FEB', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'MAR', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'APR', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'MAY', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'JUN', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'JUL', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'AUG', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'SEP', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'OKT', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'NOV', day: '99'),
              SizedBox(height: 16),
              HistoryCard(month: 'DEC', day: '99'),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
