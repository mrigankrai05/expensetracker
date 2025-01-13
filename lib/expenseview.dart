import 'package:flutter/material.dart';
import './models/expensemodel.dart';
import './expenselist.dart';

class Expenseview extends StatefulWidget {
  const Expenseview({super.key});
  @override
  State<Expenseview> createState() => _ExpenseviewState();
}

class _ExpenseviewState extends State<Expenseview> {
  final List<Expensemodel> expense = [];
  String title = "";
  double amount = 0;
  DateTime? date;
  double totalamount = 0;
  double totalsum() {
    amount = 0;
    for (Expensemodel i in expense) {
      amount += i.amount;
    }
    return amount;
  }

  void deletedata(Expensemodel a) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Text(
            "Are You Sure ?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      expense.remove(a);
                      totalamount = totalsum();
                    });
                    Navigator.of(ctx).pop();
                  },
                  child: Text("YES"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("CANCEL"),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void adddata() {
    if (title.isNotEmpty && amount > 0) {
      setState(() {
        expense.insert(
          0,
          Expensemodel(
            title: title.toUpperCase(),
            amount: amount,
            date: DateTime.now(),
          ),
        );
        totalamount = totalsum();
      });
      title = "";
      amount = 0;
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("ENTER CORRECT DATA", textAlign: TextAlign.center),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OKAY"),
              )
            ],
          );
        },
      );
      title = "";
      amount = 0;
    }
  }

  void _adddialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Enter Title",
                      hintText: "Enter the title of the expense",
                    ),
                    onChanged: (value) {
                      title = value;
                    }),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter Amount",
                            hintText: "Enter the amount of the expense",
                          ),
                          onChanged: (value) {
                            amount = double.parse(value);
                          }),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 30.0),
                ElevatedButton(onPressed: adddata, child: Text("SUBMIT"))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expense Tracker",
          textAlign: TextAlign.center,
          style:
              TextStyle(fontSize: 30.0, decoration: TextDecoration.underline),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _adddialog,
            iconSize: 40.0,
            color: Colors.blue,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              height: 130.0,
              child: Text("TOTAL EXPENSES :- $totalamount",
                  style: TextStyle(fontSize: 25.0)),
            ),
          ),
          Expanded(child: Expenselist(expense, deletedata)),
        ],
      ),
    );
  }
}
