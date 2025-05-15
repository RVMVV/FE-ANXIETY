class Validators {

static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password harus diisi';
    if (value.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Username harus diisi';
    return null;
  }
}