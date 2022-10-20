// extension allow you to add new functions to the type
// you can now write "login".orEmpty and it will work prefectally
import 'package:clean_archeticture/app/constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}
