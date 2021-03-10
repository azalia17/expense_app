import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? Column(children: [
        Text(
            'No transaction added yet',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        )
      ],) :
      ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
            //elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('${transactions[index].amount.toStringAsFixed(0)}k',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                //style: Theme.of(context).textTheme.title,
                style: TextStyle(
                  fontSize: 15.0
                ),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
              ),
              trailing: MediaQuery.of(context).size.width > 360 ? FlatButton.icon(
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Colors.red,
                onPressed: () => deleteTx(transactions[index].id),
              ) : IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => deleteTx(transactions[index].id),
              ),
            ),
          );
        },
        itemCount: transactions.length,
    );
  }
}
