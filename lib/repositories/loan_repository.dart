import 'dart:math';

import 'package:decimal/decimal.dart';

class LoanRepository {

  int calculateLoan(int capital, int length, int rate){
    int result;

    // calculate capital*(rate/12)
    var rateInt = (rate ~/ 100);
    var durationInMonth = (length*12);
    var firstValue = Decimal.fromInt(capital*(rateInt~/durationInMonth));
    // calculate 1-(1+(rate/12))^durationInMonth
    var ratePerMonthPlusOne = 1+(rateInt~/12);
    var exponent = pow(ratePerMonthPlusOne, durationInMonth);
    var secondValue = Decimal.fromInt(1-exponent);
    result = (firstValue/secondValue).toInt();

    return result;
  }

}