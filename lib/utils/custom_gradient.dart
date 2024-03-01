import 'package:flutter/material.dart';
import 'package:hrm/configuration/colors.dart';

sosLinnearGradientPrimary() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.primaryColor,
      AppColors.primaryColor,
    ],
  );
}

mainGradientPrimary() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color.fromARGB(255, 20, 29, 161),
      AppColors.primaryColor,
    ],
  );
}

sosLinearGradientYellow() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFE374),
      Color(0xFFF7B918),
    ],
  );
}

sosLinnearGradientDarkBlue() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 58, 70, 243),
      Color.fromARGB(255, 1, 9, 128),
    ],
  );
}

sosLinnearGradientDarkBlue2() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 1, 9, 128),
      Color.fromARGB(255, 58, 70, 243),
    ],
  );
}

sosLinnearGradientDarkBluePurple() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF4355F5),
      Color(0xFFDA00FF),
    ],
  );
}

sosLinnearGradientDarkPurple() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFC266FF),
      Color(0xFF8F32CC),
    ],
  );
}

sosLinnearGradientBlue2() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF587C99),
      Color(0xFF6E99BC),
    ],
  );
}

sosLinnearGradientGrey() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.dark9,
      AppColors.dark9,
    ],
  );
}

sosLinnearGradientBlue3() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF5D757C),
      Color(0xFFB3C7CD),
    ],
  );
}

LoyaltyGradientRank() {
  return LinearGradient(
    begin: Alignment(1.00, -0.05),
    end: Alignment(-1, 0.05),
    colors: [Color(0x4F7139E4), Color(0x6DDA7000)],
  );
}

RankGradient() {
  return LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFFFEEC2), Color(0xFFFFB700)],
  );
}
