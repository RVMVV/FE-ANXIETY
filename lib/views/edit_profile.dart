// ignore_for_file: unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screening_app/views/widgets/dropdown.dart';

import '../utils/constant_finals.dart';
import '../viewmodels/auth/auth_cubit.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isFormValid = false; // Status validasi form

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _selectedGender = 'Laki-laki'; // Default pilihan gender
  String? _selectedEducation; // Nilai yang dipilih untuk tingkat pendidikan
  String? _selectedJobs; // Nilai yang dipilih untuk kerjaan
  String? _selectedMarital; // Nilai yang dipilih untuk nikah
  String? _selectedDMTime; // Nilai yang dipilih untuk nikah
  String? _selectedFamilyHistory; // Nilai yang dipilih untuk riwayat keluarga

  final List<String> _educationLevels = [
    'SD',
    'SMP',
    'SMA',
    'Perguruan Tinggi',
  ]; // Pilihan tingkat pendidikan

  final List<String> _jobs = [
    'Tidak Berkerja',
    'Pegawai Sipil Negeri / Swasta',
    'Wirausaha',
    'Petani / Buruh',
    'Lainnya',
  ];
  final List<String> _marital = [
    'Menikah',
    'Belum Menikah',
    'Cerai (Janda/Duda)',
  ];
  final List<String> _dmTime = [
    '0 - 5 tahun',
    '6 - 10 tahun',
    'Lebih dari 10 tahun',
  ];

  final List<String> _familyHistory = ['Tidak ada ', 'Ada'];

  void _updateProfile() {
    final data = {
      'name': 'Lalu Bagus', // Ganti dengan nama yang sesuai
      'age':
          _ageController.text.isNotEmpty
              ? int.parse(_ageController.text)
              : null,
      'height':
          _heightController.text.isNotEmpty
              ? double.parse(_heightController.text)
              : null,
      'weight':
          _weightController.text.isNotEmpty
              ? double.parse(_weightController.text)
              : null,
      'gender': _selectedGender,
      'education': _selectedEducation,
      'occupation': _selectedJobs,
      'marriage': _selectedMarital,
      'duration': _selectedDMTime,
      'history': _selectedFamilyHistory,
    };

    context.read<AuthCubit>().updateUserProfile(data);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          Navigator.pop(context);
          context.read<AuthCubit>().getUser();
        } else if (state is UpdateUserError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: Styles.urbanistBold.copyWith(color: textColor, fontSize: 26),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(icArrowBack),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Text(
                  'Umur',
                  style: Styles.urbanistSemiBold.copyWith(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Tahun',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color:
                            _ageController.text.isEmpty
                                ? warningColor
                                : borderColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Berat Badan',
                            style: Styles.urbanistSemiBold.copyWith(
                              color: textColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Kg',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color:
                                      _ageController.text.isEmpty
                                          ? warningColor
                                          : borderColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tinggi Badan',
                            style: Styles.urbanistSemiBold.copyWith(
                              color: textColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'cm',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color:
                                      _ageController.text.isEmpty
                                          ? warningColor
                                          : borderColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Text(
                  'Jenis Kelamin',
                  style: Styles.urbanistSemiBold.copyWith(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColor,
                      width: 1,
                    ), // Border untuk container
                    borderRadius: BorderRadius.circular(16), // Radius border
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          value: 'Laki-laki',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                          title: Text(
                            'Laki-laki',
                            style: Styles.urbanistMedium.copyWith(
                              color: textColor,
                              fontSize: 14,
                            ),
                          ),
                          activeColor: primaryColor,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          value: 'Perempuan',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                          title: Text(
                            'Perempuan',
                            style: Styles.urbanistMedium.copyWith(
                              color: textColor,
                              fontSize: 14,
                            ),
                          ),
                          activeColor: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'Tingkat Pendidikan',
                  style: Styles.urbanistSemiBold.copyWith(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Dropdown<String>(
                  title: 'Pilih Tingkat Pendidikan',
                  onChanged: (value) {
                    setState(() {
                      _selectedEducation = value;
                    });
                  },
                  isiData: _educationLevels,
                ),
                const SizedBox(height: 25),
                Text(
                  'Pekerjaan',
                  style: Styles.urbanistSemiBold.copyWith(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                //Pekerjaan
                Dropdown<String>(
                  title: 'Pilih Pekerjaan',
                  onChanged: (value) {
                    setState(() {
                      _selectedJobs = value;
                    });
                  },
                  isiData: _jobs,
                ),

                const SizedBox(height: 25),
                Text(
                  'Status Pernikahan',
                  style: Styles.urbanistSemiBold.copyWith(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                //Pekerjaan
                Dropdown<String>(
                  title: 'Pilih Status Pernikahan',
                  onChanged: (value) {
                    setState(() {
                      _selectedMarital = value;
                    });
                  },
                  isiData: _marital,
                ),

                const SizedBox(height: 25),
                Text(
                  'Lama Menderita DM',
                  style: Styles.urbanistSemiBold.copyWith(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                //Lama Menderita DM
                Dropdown<String>(
                  title: 'Pilih Lama Menderita Diabetes',
                  onChanged: (value) {
                    setState(() {
                      _selectedDMTime = value;
                    });
                  },
                  isiData: _dmTime,
                ),
                const SizedBox(height: 25),
                Text(
                  'Riwayat Keluarga dengan DM',
                  style: Styles.urbanistSemiBold.copyWith(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                //Riwayat Keluarga Menderita DM
                Dropdown<String>(
                  title: 'Pilih Riwayat Keluarga',
                  onChanged: (value) {
                    setState(() {
                      _selectedFamilyHistory = value;
                    });
                  },
                  isiData: _familyHistory,
                ),
                const SizedBox(height: 50),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _updateProfile();
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor, // Warna tombol
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: SizedBox(
                      width: screenWidth,
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: Styles.urbanistBold.copyWith(
                            color: whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }
}
