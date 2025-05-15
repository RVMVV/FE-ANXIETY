import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constant_finals.dart';

class Dropdown<T> extends StatelessWidget {
  const Dropdown({
    super.key,
    required this.isiData,
    this.onChanged,
    required this.title,
  });
  final List<T> isiData;
  final String title;

  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: SvgPicture.asset(icArrowDown),
      hint: Text(
        title,
        style: Styles.urbanistMedium.copyWith(
          color: textColor.withAlpha(80),
          fontSize: 14,
        ),
      ),
      onChanged: onChanged,
      items:
          isiData.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
    );
  }
}
