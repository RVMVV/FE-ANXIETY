import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

final apiUrl = dotenv.get('BASE_URL');
final authEndpoint = dotenv.get('AUTH_ENDPOINT');
final quizEndpoint = dotenv.get('QUIZ_ENDPOINT');

final String materiMSPSS = "Pernahkah kamu merasa seolah-olah beban di pundakmu terlalu berat untuk ditanggung sendiri? Atau mungkin kamu sedang menghadapi tantangan dan merasa sendirian? Di sinilah dukungan sosial berperan penting.\n Dukungan sosial adalah tentang perasaan didukung dan diperhatikan oleh orang-orang di sekitarmu, entah itu keluarga, teman, pasangan, atau bahkan komunitas. Ini bukan hanya soal mendapatkan bantuan fisik, tapi juga tentang tahu bahwa ada seseorang yang peduli dan bersedia mendengarkan. \n Mengurangi Stres dan Kecemasan: Ketika kamu tahu ada orang lain yang peduli, beban masalah terasa lebih ringan. Kamu memiliki tempat aman untuk berbagi kekhawatiranmu, yang bisa sangat membantu meredakan stres dan kecemasan \n Meningkatkan Kesehatan Mental: Studi menunjukkan bahwa orang dengan dukungan sosial yang kuat cenderung memiliki tingkat depresi dan kecemasan yang lebih rendah. Mereka merasa lebih optimis dan mampu menghadapi tantangan hidup. \n Membangun Resiliensi: Dukungan sosial membantumu bangkit kembali dari kesulitan. Saat kamu jatuh, ada tangan yang siap membantumu berdiri lagi. Ini membangun kekuatan mental dan emosionalmu. \n Meningkatkan Motivasi: Terkadang, kita hanya butuh sedikit dorongan atau pujian dari orang lain untuk terus maju. Dukungan sosial bisa menjadi sumber motivasi yang kuat untuk mencapai tujuanmu. \n Merasa Lebih Berharga dan Dicintai: Tahu bahwa ada orang yang peduli denganmu meningkatkan harga dirimu. Kamu merasa diinginkan dan bagian dari sesuatu yang lebih besar, yang sangat penting untuk kesejahteraan emosional.";
//Warna Utama
const Color backgroundColor = Color(0xFFF8F8FF);
const Color whiteColor = Color(0xFFFFFFFF);
const Color textColor = Color(0xFF494949);
const Color primaryColor = Color(0xFF14B8AD);
const Color onahau = Color(0xFFC6ECE8);
const Color deepTeal = Color(0xFF0E7F79);

// Warna Sekunder
const Color warningColor = Color(0xFFF33459);
const Color backgroundWarningColor = Color(0xFFFFF1F4);
const Color borderColor = Color(0xFFB7B7B7);
const Color gapColor = Color(0xFFEDEDED);

// styles
class Styles {
  static final TextStyle urbanistRegular = GoogleFonts.urbanist(
    fontWeight: FontWeight.w400,
  );
  static final TextStyle urbanistMedium = GoogleFonts.urbanist(
    fontWeight: FontWeight.w500,
  );
  static final TextStyle urbanistSemiBold = GoogleFonts.urbanist(
    fontWeight: FontWeight.w600,
  );
  static final TextStyle urbanistBold = GoogleFonts.urbanist(
    fontWeight: FontWeight.w700,
  );
  static final TextStyle urbanistExtraBold = GoogleFonts.urbanist(
    fontWeight: FontWeight.w800,
  );
}

//icon
const String icLoc = 'assets/svg/';
const String icHome = '${icLoc}home_ic.svg';
const String icHistory = '${icLoc}history_ic.svg';
const String icSetting = '${icLoc}gear_ic.svg';
const String icArrow = '${icLoc}arrow_ic.svg';
const String icMeditation = '${icLoc}meditation_ic.svg';
const String icEdit = '${icLoc}edit_ic.svg';
const String icLogOut = '${icLoc}logout_ic.svg';
const String icWarning = '${icLoc}warning_ic.svg';
const String icArrowDown = '${icLoc}arrow_down_ic.svg';
const String icArrowBack = '${icLoc}back_arrow_ic.svg';
const String icForbidden = '${icLoc}forbidden_ic.svg';
const String icDone = '${icLoc}done_ic.svg';
const String icTripleUser = '${icLoc}user_triple_ic.svg';
const String icCross = '${icLoc}cross_ic.svg';

// emotion
const String imgLoc = 'assets/img/';
const String imgBahagia = '${imgLoc}happykiyowo.png';
const String imgRingan = '${imgLoc}ringan.png';
const String imgSedang = '${imgLoc}sedang.png';
const String imgBerat = '${imgLoc}berat.png';
const String imgStress = '${imgLoc}ancok.png';
