import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screening_app/utils/constant_finals.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: backgroundWarningColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: textColor.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: warningColor.withValues(alpha: 1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Row(
          children: [
            SvgPicture.asset(icWarning, width: 20, height: 20),
            const SizedBox(width: 25),
            Text(
              'isi data profile terlebih dahulu',
              style: Styles.urbanistSemiBold.copyWith(
                color: warningColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
