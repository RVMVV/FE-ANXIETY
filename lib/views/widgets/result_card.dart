import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constant_finals.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.screenWidth,
    required this.icon,
    required this.title,
    required this.emotion,
    required this.score,
    required this.material,
  });
  final String icon;
  final String title;
  final String emotion;
  final double screenWidth;
  final String score;
  final String material;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: screenWidth,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: textColor.withAlpha(30),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          //top section
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: onahau,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: SvgPicture.asset(icon, width: 30, height: 30),
                ),
              ),
              SizedBox(width: 15),
              Text(
                title,
                style: Styles.urbanistBold.copyWith(
                  color: textColor,
                  fontSize: 26,
                ),
              ),
            ],
          ),

          //emotion
          const SizedBox(height: 30),
          Image.asset(emotion, width: 105, height: 105),
          const SizedBox(height: 15),
          Text(
            'Tidak Ansietas',
            style: Styles.urbanistBold.copyWith(
              color: primaryColor,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Skor $title $score',
            style: Styles.urbanistBold.copyWith(color: textColor, fontSize: 18),
          ),
          const SizedBox(height: 50),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Video Edukasi',
              style: Styles.urbanistBold.copyWith(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: screenWidth,
            height: 160,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: textColor.withAlpha(30),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Placeholder Video Edukasi',
                style: Styles.urbanistMedium.copyWith(
                  color: textColor,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Materi Edukasi',
              style: Styles.urbanistBold.copyWith(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              textAlign: TextAlign.justify,
              style: Styles.urbanistRegular.copyWith(
                color: textColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
