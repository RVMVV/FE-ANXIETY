// // Ini adalah halaman untuk menampilkan kuis kepada pengguna

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:screening_app/viewmodels/quiz/quiz_cubit.dart';

// import '../utils/constant_finals.dart';
// import 'result.dart';

// // Halaman utama untuk kuis
// class QuizPage extends StatefulWidget {
//   const QuizPage({super.key});

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   // Controller untuk mengontrol halaman kuis
//   final PageController _pageController = PageController();

//   // Indeks tipe kuis saat ini
//   int _currentQuizTypeIndex = 0;

//   // Indeks pertanyaan saat ini
//   int _currentPageIndex = 0;

//   // Label untuk slider
//   List<String> sliderLabelsMSPSS = [
//     'Sangat Tidak Setuju',
//     'Tidak Setuju',
//     'Agak Tidak Setuju',
//     'Netral',
//     'Agak Setuju',
//     'Setuju',
//     'Sangat Setuju',
//   ];

//   List<String> sliderLabelsQDoL1 = [
//     'Tidak Puas',
//     'Cukup Tidak Puas',
//     'Netral',
//     'Cukup Puas',
//     'Sangat Puas',
//   ];
//   List<String> sliderLabelsQDoL2 = [
//     'Tidak Pernah',
//     'Jarang',
//     'Kadang-Kadang',
//     'Sering',
//     'Selalu',
//   ];

//   // Buat simpen jawaban
//   Map<dynamic, int> questionWeights = {};
//   // Nilai slider
//   double sliderValue = 0;

//   @override
//   void initState() {
//     // Meminta data kuis dari server saat halaman dimulai
//     context.read<QuizCubit>().getQuiz();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<QuizCubit, QuizState>(
//       builder: (context, state) {
//         if (state is QuizLoading) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator(color: primaryColor)),
//           );
//         } else if (state is QuizSuccess) {
//           // Ambil data kuis
//           final quizData = state.quizResponse.data;

//           // Kelompokkan data berdasarkan tipe kuis
//           final quizTypes =
//               quizData.map((quiz) => quiz.quizType.type).toSet().toList();

//           // Pastikan indeks tipe kuis tidak melebihi jumlah tipe kuis
//           if (_currentQuizTypeIndex >= quizTypes.length) {
//             _currentQuizTypeIndex = quizTypes.length - 1;
//           }

//           // Ambil tipe kuis saat ini
//           final currentQuizType = quizTypes[_currentQuizTypeIndex];

//           // Filter data untuk tipe kuis saat ini
//           final filteredQuizData =
//               quizData
//                   .where((quiz) => quiz.quizType.type == currentQuizType)
//                   .toList();

//           // Periksa apakah tipe kuis memiliki judul (title)
//           final hasTitle = filteredQuizData.any((quiz) => quiz.title != null);

//           // Jika ada judul, ambil daftar judul unik
//           final titles =
//               hasTitle
//                   ? filteredQuizData.map((quiz) => quiz.title).toSet().toList()
//                   : [];

//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 // Tampilkan nama tipe kuis di bagian atas
//                 currentQuizType,
//                 style: Styles.urbanistBold.copyWith(
//                   color: textColor,
//                   fontSize: 26,
//                 ),
//               ),
//               leading: IconButton(
//                 onPressed: () {
//                   // Kembali ke halaman sebelumnya
//                   Navigator.pop(context);
//                 },
//                 icon: SvgPicture.asset(icArrowBack),
//               ),
//             ),
//             body: Column(
//               children: [
//                 // Bagian utama untuk menampilkan pertanyaan
//                 Expanded(
//                   child: PageView.builder(
//                     controller: _pageController,
//                     onPageChanged: (index) {
//                       // Perbarui indeks halaman saat ini
//                       setState(() {
//                         _currentPageIndex = index;
//                       });
//                     },
//                     // Jumlah halaman tergantung pada apakah ada judul atau tidak
//                     itemCount:
//                         hasTitle ? titles.length : filteredQuizData.length,
//                     itemBuilder: (context, index) {
//                       if (hasTitle) {
//                         // Jika ada judul, tampilkan pertanyaan berdasarkan judul
//                         final filteredQuestions =
//                             filteredQuizData
//                                 .where((quiz) => quiz.title == titles[index])
//                                 .toList();

//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 15),
//                               // Tampilkan judul
//                               Text(
//                                 titles[index] ?? 'No Title',
//                                 style: Styles.urbanistBold.copyWith(
//                                   color: textColor,
//                                   fontSize: 24,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               // Tampilkan daftar pertanyaan
//                               Expanded(
//                                 child: ListView.builder(
//                                   itemCount: filteredQuestions.length,
//                                   itemBuilder: (context, questionIndex) {
//                                     final question =
//                                         filteredQuestions[questionIndex];
//                                     return Padding(
//                                       padding: const EdgeInsets.only(
//                                         bottom: 10,
//                                       ),
//                                       child: Text(
//                                         '${questionIndex + 1}. ${question.question}',
//                                         style: Styles.urbanistRegular.copyWith(
//                                           color: textColor,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               // const SizedBox(height: 20),
//                               StatefulBuilder(
//                                 builder: (context, setState) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SliderTheme(
//                                         data: SliderTheme.of(context).copyWith(
//                                           trackHeight: 8,
//                                           activeTrackColor: primaryColor,
//                                           inactiveTrackColor: primaryColor
//                                               .withAlpha(30),
//                                           thumbColor: primaryColor,
//                                           overlayColor: primaryColor.withAlpha(
//                                             50,
//                                           ),
//                                           valueIndicatorColor: whiteColor,
//                                           valueIndicatorTextStyle: Styles
//                                               .urbanistBold
//                                               .copyWith(
//                                                 color: textColor,
//                                                 fontSize: 30,
//                                               ),
//                                           valueIndicatorShape:
//                                               RectangularSliderValueIndicatorShape(),
//                                         ),
//                                         child: Slider(
//                                           value: sliderValue,
//                                           min: 0,
//                                           max: 4,
//                                           divisions: 4,
//                                           label: sliderValue.round().toString(),
//                                           onChanged: (value) {
//                                             setState(() {
//                                               sliderValue = value;
//                                               questionWeights[index] =
//                                                   value.toInt() + 1;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                               SizedBox(height: 300),
//                             ],
//                           ),
//                         );
//                       } else {
//                         // Jika tidak ada judul, tampilkan satu pertanyaan per halaman
//                         final question = filteredQuizData[index];

//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             children: [
//                               const SizedBox(height: 30),
//                               Text(
//                                 question.question,
//                                 style: Styles.urbanistBold.copyWith(
//                                   color: textColor,
//                                   fontSize: 24,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                               const SizedBox(height: 150),
//                               StatefulBuilder(
//                                 builder: (context, setState) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SliderTheme(
//                                         data: SliderTheme.of(context).copyWith(
//                                           trackHeight: 8,
//                                           activeTrackColor: primaryColor,
//                                           inactiveTrackColor: primaryColor
//                                               .withAlpha(30),
//                                           thumbColor: primaryColor,
//                                           overlayColor: primaryColor.withAlpha(
//                                             50,
//                                           ),
//                                           valueIndicatorColor: whiteColor,
//                                           valueIndicatorTextStyle: Styles
//                                               .urbanistSemiBold
//                                               .copyWith(
//                                                 color: textColor,
//                                                 fontSize: 20,
//                                               ),
//                                           valueIndicatorShape:
//                                               RectangularSliderValueIndicatorShape(),
//                                         ),
//                                         child: Slider(
//                                           value: sliderValue,
//                                           min: 0,
//                                           max:
//                                               (currentQuizType ==
//                                                           "Quality of Life"
//                                                       ? (_currentPageIndex < 7
//                                                           ? sliderLabelsQDoL1
//                                                                   .length -
//                                                               1
//                                                           : sliderLabelsQDoL2
//                                                                   .length -
//                                                               1)
//                                                       : sliderLabelsMSPSS
//                                                               .length -
//                                                           1)
//                                                   .toDouble(),
//                                           divisions:
//                                               currentQuizType ==
//                                                       "Quality of Life"
//                                                   ? (_currentPageIndex < 7
//                                                       ? sliderLabelsQDoL1
//                                                               .length -
//                                                           1
//                                                       : sliderLabelsQDoL2
//                                                               .length -
//                                                           1)
//                                                   : sliderLabelsMSPSS.length -
//                                                       1,
//                                           label:
//                                               currentQuizType ==
//                                                       "Quality of Life"
//                                                   ? (_currentPageIndex < 7
//                                                       ? sliderLabelsQDoL1[sliderValue
//                                                           .toInt()]
//                                                       : sliderLabelsQDoL2[sliderValue
//                                                           .toInt()])
//                                                   : sliderLabelsMSPSS[sliderValue
//                                                       .toInt()],
//                                           onChanged: (double value) {
//                                             setState(() {
//                                               sliderValue = value;
//                                               questionWeights[question.id] =
//                                                   sliderValue.toInt() + 1;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 // Tombol navigasi (Kembali dan Lanjut)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Tombol "Kembali"
//                       if (_currentPageIndex > 0)
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               // Pindah ke halaman sebelumnya
//                               _pageController.previousPage(
//                                 duration: const Duration(milliseconds: 300),
//                                 curve: Curves.easeInOut,
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: whiteColor,
//                               shadowColor: textColor,
//                               minimumSize: const Size.fromHeight(50),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text(
//                               'Kembali',
//                               style: Styles.urbanistBold.copyWith(
//                                 color: primaryColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       if (_currentPageIndex > 0) const SizedBox(width: 20),
//                       // Tombol "Lanjut" atau "Selesai"
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_currentPageIndex <
//                                 (hasTitle
//                                         ? titles.length
//                                         : filteredQuizData.length) -
//                                     1) {
//                               // Pindah ke halaman berikutnya
//                               _pageController.nextPage(
//                                 duration: const Duration(milliseconds: 300),
//                                 curve: Curves.easeInOut,
//                               );
//                               setState(() {
//                                 sliderValue = 0;
//                               });
//                             } else if (_currentQuizTypeIndex <
//                                 quizTypes.length - 1) {
//                               // Pindah ke tipe kuis berikutnya
//                               setState(() {
//                                 _currentQuizTypeIndex++;
//                                 _currentPageIndex = 0;
//                                 _pageController.jumpToPage(0);
//                               });
//                             } else {
//                               // Jika semua kuis selesai, cetak hasil bobot ke konsol
//                               print("Hasil Question Weights:");
//                               print(questionWeights);
//                               // Jika semua kuis selesai, pindah ke halaman hasil
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const HasilPage(),
//                                 ),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: primaryColor,
//                             minimumSize: const Size.fromHeight(50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: Text(
//                             _currentPageIndex <
//                                     (hasTitle
//                                             ? titles.length
//                                             : filteredQuizData.length) -
//                                         1
//                                 ? 'Lanjut'
//                                 : (_currentQuizTypeIndex < quizTypes.length - 1
//                                     ? 'Berikutnya'
//                                     : 'Selesai'),
//                             style: Styles.urbanistBold.copyWith(
//                               color: whiteColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           );
//         }
//         // Jika terjadi error, tampilkan pesan error
//         return const Scaffold(
//           backgroundColor: backgroundColor,
//           body: Center(child: Text('Something went wrong')),
//         );
//       },
//     );
//   }
// }


