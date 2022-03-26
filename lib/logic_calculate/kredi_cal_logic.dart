// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';

////________ формула расчёта кредита _________\\\\

// var items = <int>[];

class SimpleCalcWidgetModel extends ChangeNotifier {
  int? _sumKred; // сумма кредита
  int? _period; // период в месяцах
  int? _protStavka; // годовая процентная ставка
  int? intPaying;
  int? intPayment;

  double? debt; // долг на начало месяца
  double? debtPros; // процент долга
  double? payment; // сумма
  double? paying; // сумма оплаты

  double? montPaying; // суммы оплаты каждый месяц
  double? monthProc; // проц. ставка каждого месяца
  double? remainderProc; // процент остатки
  double? remainderSum; // остаток суммы
  double? bodyCred; // тело кредита
  double? x, y, d;

  set sumKred(String value) => _sumKred = int.tryParse(value);
  set period(String value) => _period = int.tryParse(value);
  set protStavka(String value) => _protStavka = int.tryParse(value);

  void recultcalcDiff() {
    double? payment;

    if (_sumKred != null && _period != null && _protStavka != null) {
      debt = _sumKred as double?;
      paying = 0;
      for (int i = 1; i <= _period!; i++) {
        debtPros = debt! * (_protStavka! / 12 / 100);
        paying = paying! + debtPros!;
        payment = _sumKred! / _period! + debtPros!;
        // print( ' %2i      %9.0f     %9.0f   %9.0f\n',  i,  debt,  debtPros,  payment);
        // final iteration = i;
        // items.add(iteration);
        intPayment = (payment).round();
        debt = debt! - _sumKred! / _period!;
      }
    } else {
      payment = null;
    }
    if (this.payment != payment) {
      this.payment = payment;
      notifyListeners();
    }
  }

  void recultcalcAnnu() {
    double? montPaying;

    if (_sumKred != null && _period != null && _protStavka != null) {
      monthProc = _protStavka! / 100 / 12;
      d = monthProc! + 1;
      x = pow(d!, _period!) as double?;
      y = monthProc! + (monthProc! / (x! - 1));
      montPaying = _sumKred! * y!;
      remainderSum = _sumKred as double?;

      for (int i = 1; i <= _period!; i++) {
        bodyCred = montPaying - (remainderSum! * monthProc!);
        remainderSum = remainderSum! - bodyCred!;
        remainderProc = montPaying - bodyCred!;
        // print(' %2i     %9.0f     %9.0f     %9.0f    %9.0f\n',  i, remainderSum, bodyCred, remainderProc, montPaying);
        intPaying = (montPaying).round();
      }
    } else {
      montPaying = null;
    }
    if (this.montPaying != montPaying) {
      this.montPaying = montPaying;
      notifyListeners();
    }
  }
}

class SimpleCalcWidgetProvider
    extends InheritedNotifier<SimpleCalcWidgetModel> {
  final SimpleCalcWidgetModel model;

  const SimpleCalcWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static SimpleCalcWidgetModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()
        ?.notifier;
  }

  static SimpleCalcWidgetModel? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()
        ?.widget;
    return widget is SimpleCalcWidgetProvider ? widget.notifier : null;
  }

  @override
  bool updateShouldNotify(SimpleCalcWidgetProvider oldWidget) {
    return notifier != oldWidget.notifier;
  }
}

// class TableCalculation extends StatefulWidget {
//   const TableCalculation({Key? key}) : super(key: key);

//   @override
//   _TableCalculationState createState() => _TableCalculationState();
// }

// class _TableCalculationState extends State<TableCalculation> {
//   @override
//   Widget build(BuildContext context) {
//     return DataTable(
//       columns: const [
//         DataColumn(label: Text('Месяц')),
//         // DataColumn(label: Text('Сумма остатка')),
//         // DataColumn(label: Text('Процент')),
//         // DataColumn(label: Text('Оплата')),
//       ],
//       rows: [
//         DataRow(cells: [
//           DataCell(Text('$items')),
//         ]),
//       ],
//     );
//   }
// }
