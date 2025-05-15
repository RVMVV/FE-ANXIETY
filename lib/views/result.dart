import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screening_app/views/fragment.dart';

import '../utils/constant_finals.dart';
import 'widgets/result_card.dart';

class HasilPage extends StatelessWidget {
  const HasilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil',
          style: Styles.urbanistBold.copyWith(color: textColor, fontSize: 26),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => FragmentPage()),
              (route) => false,
            );
          },
          icon: SvgPicture.asset(icArrowBack),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              ResultCard(
                screenWidth: screenWidth,
                icon: icMeditation,
                title: 'HARS.',
                emotion: imgBahagia,
              ),
              SizedBox(height: 20),
              ResultCard(
                screenWidth: screenWidth,
                icon: icTripleUser,
                title: 'MSPSS.',
                emotion: imgBerat,
              ),
              SizedBox(height: 20),
              ResultCard(
                screenWidth: screenWidth,
                icon: icDone,
                title: 'DQoL.',
                emotion: imgStress,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
