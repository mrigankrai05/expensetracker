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
                Text(
                  "ADD NEW EXPENSE",
                  style: TextStyle(fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Enter Title",
                    hintText: "Enter the title of the expense",
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Enter Amount", prefixText: "₹ "),
                  onChanged: (value) {
                    amount = double.parse(value);
                  },
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: adddata, child: Text("SUBMIT")),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("CANCEL"),
                    ),
                  ],
                )
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
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 19, 12, 20),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adddialog,
        backgroundColor: const Color.fromARGB(255, 114, 156, 210),
        child: Icon(Icons.add),
        tooltip: "Add Expense",
      ),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Stretch to fill the width
        children: [
          Column(
            children: [
              SizedBox(height: 10.0), // Add spacing between elements
              Text(
                "TOTAL EXPENSES: ₹$totalamount",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expenselist(expense, deletedata),
            ),
          ),
        ],
      ),
    );
  }
}
