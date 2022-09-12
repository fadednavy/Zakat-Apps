import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_zakat/utils/constants.dart' as Constants;
import 'package:do_zakat/utils/flutter_masked_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class KalZakatProfesi extends StatefulWidget {
  KalZakatProfesi({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KalZakatProfesiState createState() => _KalZakatProfesiState();
}

class _KalZakatProfesiState extends State<KalZakatProfesi> {
  // Group of VARIABLE
  int monthlySalary = 0;
  int otherIncome = 0;
  int totalIncome = 0;
  int monthlyInstallment = 0;
  int monthlyAlm = 0;

  // Group of CONTROLLER
  final tfSalaryController = MoneyMaskedTextController();
  final tfOtherIncomeController = MoneyMaskedTextController();
  final tfInstallmentController = MoneyMaskedTextController();
  final tfAlmController = MoneyMaskedTextController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tfSalaryController.dispose();
    tfOtherIncomeController.dispose();
    tfInstallmentController.dispose();
    tfAlmController.dispose();
    super.dispose();
  }

  // Group of UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Color(0xffbf905f),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xff003c35),
                Color(0xff002924),
              ],
            ),
          ),
        ),
        title: GradientText(
          "Kalkulator Zakat Profesi",
          style: TextStyle(fontSize: 18.0),
          colors: [
            Color(0xffebbb7e),
            Color(0xffbf905f),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            TextField(
              controller: tfSalaryController,
              maxLength: 15,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff003c35), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xff003c35),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Gaji Per Bulan",
                  hintText: "0",
                  prefixText: Constants.CURRENCY),
            ),
            SizedBox(height: 20),
            TextField(
              controller: tfOtherIncomeController,
              maxLength: 15,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff003c35), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xff003c35),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Pendapatan lain",
                  hintText: "0",
                  prefixText: Constants.CURRENCY),
            ),
            SizedBox(height: 20),
            TextField(
              controller: tfInstallmentController,
              maxLength: 15,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff003c35), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xff003c35),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Hutang / Cicilan",
                  hintText: "0",
                  prefixText: Constants.CURRENCY),
            ),
            SizedBox(height: 20),
            TextField(
              controller: tfAlmController,
              maxLength: 15,
              readOnly: true,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff003c35), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xff003c35),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Zakat Anda",
                  hintText: "0",
                  prefixText: Constants.CURRENCY),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: MaterialButton(
                  color: Color(0xff003c35),
                  onPressed: _countMonthlyAlms,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Hitung Zakat",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Group of EVENT METHOD
  void _countMonthlyAlms() {
    setState(() {
      monthlySalary = getIntValue(tfSalaryController);
      otherIncome = getIntValue(tfOtherIncomeController);
      monthlyInstallment = getIntValue(tfInstallmentController);
      double alms = 0.025 * (monthlySalary + otherIncome - monthlyInstallment);
      monthlyAlm = alms.round();
      tfAlmController.text = monthlyAlm.toString();
    });
  }

  int getIntValue(MoneyMaskedTextController controller) {
    return int.tryParse(controller.text.replaceAll(".", "")) ?? 0;
  }
}
