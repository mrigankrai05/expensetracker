import 'package:flutter/material.dart';
import './models/expensemodel.dart';
import 'package:intl/intl.dart';

class Expenselist extends StatelessWidget {
  const Expenselist(this.expense, this.deletedata, {super.key});
  final List<Expensemodel> expense;
  final void Function(Expensemodel) deletedata;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (ctx, index) => Card(
        color: expense[index].category.name == "Credit"? const Color.fromARGB(255, 125, 210, 128) : const Color.fromARGB(255, 253, 99, 88),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                      child: Text(
                        "AMOUNT :- ${expense[index].amount}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Text("${expense[index].category.name}",
                        style: TextStyle(fontSize: 18.0)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        expense[index].title,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          DateFormat('dd-MM-yyy – kk:mm')
                              .format(expense[index].date),
                          style: TextStyle(fontSize: 15.0)),
                    )
                  ],
                )
              ],
            ),
            IconButton(
              onPressed: () {
                deletedata(expense[index]);
              },
              icon: Icon(Icons.delete),
              iconSize: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
