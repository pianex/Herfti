nameValidator(String? text) {
  if (text!.isEmpty) {
    return "لا يمكن أن يبقى الحقل فارغا.";
  } else if (text.length > 30) {
    return "الإسم طويل جدا.";
  } else {
    return null;
  }
}

servicesValidator(String? text) {
  if (text!.length > 200) {
    return "الخدمات طويلة جدا.";
  } else {
    return null;
  }
}

postValidator(String? text) {
  if (text!.length > 200) {
    return "المشور طويل جدا.";
  } else {
    return null;
  }
}

phoneValidator(String? text) {
  if (text!.isEmpty) {
    return "لا يمكن أن يبقى الحقل فارغا.";
  } else if (text.length < 10 ||
      text.length > 10 ||
      text.contains(RegExp(r'[^0-9]')) ||
      !text.startsWith('0')) {
    return "الرقم خاطئ.";
  } else {
    return null;
  }
}

whatsappValidator(String? text) {
  if (text!.isEmpty) {
    return null;
  } else if (text.length < 10 ||
      text.length > 10 ||
      text.contains(RegExp(r'[^0-9]')) ||
      !text.startsWith('0')) {
    return "الرقم خاطئ.";
  } else {
    return null;
  }
}

locationValidator(String? text) {
  if (text!.isEmpty) {
    return 'إضغط لتحديد موقعك.';
  } else {
    return null;
  }
}

priceValidator(String? text) {
  if (text!.isEmpty) {
    return "لا يمكن أن يبقى الحقل فارغا.";
  } else if (text.contains(RegExp(r'[^0-9]'))) {
    return "الرقم خاطئ.";
  } else {
    return null;
  }
}

pinValidator(String? text) {
  if (text!.isEmpty) {
    return "لا يمكن أن يبقى الحقل فارغا.";
  } else if (text.contains(RegExp(r'[^0-9]')) ||
      text.length < 4 ||
      text.length > 4) {
    return "يجب أن يتكون الرمز من 4 أرقام.";
  } else {
    return null;
  }
}
