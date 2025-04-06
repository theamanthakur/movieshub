import 'config.dart';

extension CustomThemeData on ThemeData {
  bool get isDarkMode {
    if (brightness == Brightness.light) {
      return false;
    } else {
      return true;
    }
  }

  Color get selectedChipText {
    if (brightness == Brightness.light) {
      return const Color(0xFFFFFFFF);
    } else {
      return const Color(0xFFFFFFFF);
    }
  }

  Color get unselectedChipText {
    if (brightness == Brightness.light) {
      return Color(0xFF633CBA);
    } else {
      return Color(0xFFF9F9F9);
    }
  }

  Color get profileTopCard {
    if (brightness == Brightness.light) {
      return const Color(0xFFEFA22F);
    } else {
      return const Color(0xFF483573);
    }
  }

  Color get energyBg {
    if (brightness == Brightness.light) {
      return const Color(0xFFFFF7E5);
    } else {
      return const Color(0xFF483573);
    }
  }

  Color get googleBtnColor {
    if (brightness == Brightness.light) {
      return const Color(0xFFFFFFFF);
    } else {
      return const Color(0xFF323539);
    }
  }

  Color get appleBtnColor {
    if (brightness == Brightness.light) {
      return const Color(0xFF000000);
    } else {
      return const Color(0xFFFFFFFF);
    }
  }

  Color get chipBorder {
    if (brightness == Brightness.light) {
      return const Color(0xFFEAEBF0);
    } else {
      return const Color(0xFF323539);
    }
  }

  Color get chipText {
    if (brightness == Brightness.light) {
      return const Color(0xFFEAEBF0);
    } else {
      return const Color(0xFF323539);
    }
  }

  Color get textFieldBorder {
    if (brightness == Brightness.light) {
      return const Color(0xFFC8C6FF);
    } else {
      return const Color(0xFF3B3053);
    }
  }

  Color get bottomSheetColor {
    if (brightness == Brightness.light) {
      return const Color(0xFFFFFFFF);
    } else {
      return const Color(0xFF17161A);
    }
  }

  Color get bdCircleItem {
    if (brightness == Brightness.light) {
      return const Color(0xFFFFFFFF).withOpacity(0.4);
    } else {
      return const Color(0xFF29262F);
    }
  }

  Color get dividerColorLine {
    if (brightness == Brightness.light) {
      return const Color(0xFFEAEBF0);
    } else {
      return const Color(0xFF323539);
    }
  }

  Color get textWhitePurple {
    if (brightness == Brightness.light) {
      return const Color(0xFF7C55D4);
    } else {
      return const Color(0xFFFFFFFF);
    }
  }

  Color get textGrayWhite {
    if (brightness == Brightness.light) {
      return const Color(0xFF7C55D4);
    } else {
      return const Color(0xFFFFFFFF);
    }
  }

  Color get inputTextField {
    if (brightness == Brightness.light) {
      return const Color(0xFFE9E0FF);
    } else {
      return const Color(0xFF383049);
    }
  }

  Color get bottomBorder {
    if (brightness == Brightness.light) {
      return const Color(0xFFC3BCD1);
    } else {
      return const Color(0xFF323539);
    }
  }

  Color get disableScreenBg {
    if (brightness == Brightness.light) {
      return const Color(0xFFFFFFFF).withOpacity(0.8);
    } else {
      return const Color(0xFF000000).withOpacity(0.8);
    }
  }

}
