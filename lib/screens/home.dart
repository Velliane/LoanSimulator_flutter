import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:loan_simulator/view_model/homeViewModel.dart';
import 'package:provider/provider.dart';

TextEditingController capitalController = TextEditingController();
TextEditingController lengthController = TextEditingController();
TextEditingController rateController = TextEditingController();
int capital;
int length;
int rate;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    capitalController.dispose();
    lengthController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Simulator"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Calculer vos mensualités", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.indigo), textAlign: TextAlign.center,),
            Padding(
              padding: const EdgeInsets.only(
                left: 10, right: 10, top: 5,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Capital emprunté",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.house)),
                controller: capitalController,
                keyboardType: TextInputType.number,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "error";
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Durée",
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.calendar_today_outlined)),
                      controller: lengthController,
                      keyboardType: TextInputType.number,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "error";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Taux",
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.attach_money)),
                      controller: rateController,
                      keyboardType: TextInputType.number,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "error";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      capital = int.parse(capitalController.text);
                      length = int.parse(lengthController.text);
                      rate = int.parse(rateController.text);
                      showDialog(context: context, builder: showAlertDialog);
                    }
                  },
                  child: Text("Calculer", style: TextStyle(fontSize: 20),)),
            )
          ],
        ),
      ),
    );
  }
}

Widget showAlertDialog(BuildContext context) {
  Provider.of<HomeViewModel>(context).getResult(capital, length, rate);
  var result = Provider.of<HomeViewModel>(context).result;
  return AlertDialog(
    content: Text("Vos mensualités sont de $result €"),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("ok"))
    ],
  );
}
