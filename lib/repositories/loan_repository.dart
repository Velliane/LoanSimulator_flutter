import 'dart:math';

import 'package:decimal/decimal.dart';

class LoanRepository {

  int calculateLoan(int capital, int length, double rate){
    int result;

    // calculate capital*(rate/12)
    var rateInt = rate/Decimal.fromInt(100).toDouble();
    var durationInMonth = (length*12);
    var firstValue = capital*(rateInt/12);
    // calculate 1-(1+(rate/12))^durationInMonth
    var ratePerMonthPlusOne = 1+(rateInt/12);
    var exponent = pow(ratePerMonthPlusOne, -durationInMonth);
    var secondValue = 1-exponent;
    result = (firstValue/secondValue).truncate();

    return result;
  }

}