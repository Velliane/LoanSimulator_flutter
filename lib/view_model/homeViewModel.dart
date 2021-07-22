import 'package:flutter/cupertino.dart';
import 'package:loan_simulator/repositories/loan_repository.dart';

class HomeViewModel with ChangeNotifier {

  int result;

  Future<void> getResult(int capital, int length, int rate) async {
    result = LoanRepository().calculateLoan(capital, length, rate);
    notifyListeners();
  }


}
