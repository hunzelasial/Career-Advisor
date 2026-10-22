String? validateFullName(String? value) =>
    (value?.trim().length ?? 0) >= 2 ? null : 'Enter your full name';

String? validatePhoneNumber(String? value) =>
    RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(value ?? '')
    ? null
    : 'Use international format, e.g. +923001234567';

String? validateEmail(String? value) =>
    value != null &&
        RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())
    ? null
    : 'Enter a valid email address';

String? validatePassword(String? value) =>
    (value?.length ?? 0) >= 8 ? null : 'Use at least 8 characters';
