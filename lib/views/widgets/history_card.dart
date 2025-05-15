
import 'package:flutter/material.dart';

import '../../utils/constant_finals.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.month,
    required this.day,
    this.screenWidth,
  });

  final String month, day;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: 85,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: textColor.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      children: [
                        Text(
                          month,
                          style: Styles.urbanistSemiBold.copyWith(
                            color: whiteColor,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          day,
                          style: Styles.urbanistExtraBold.copyWith(
                            color: whiteColor,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Screening',
                  style: Styles.urbanistExtraBold.copyWith(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Lihat hasil screeningmu disini',
                  style: Styles.urbanistRegular.copyWith(
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
