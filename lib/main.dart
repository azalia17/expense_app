import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './palette.dart';

void main() {
  /*SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /*visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        canvasColor: Colors.transparent,
        primarySwatch: Palette.ijo*/
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
        canvasColor: Colors.grey[200],
        //accentColor: Colors.amber
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    /*Transaction(
        id: 't1',
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now()
    ),
    Transaction(
        id: 't2',
        title: 'New Shoes',
        amount: 19.99,
        date: DateTime.now()
    ),*/
  ];

  bool _showChart = false;
  
  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        )
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount / 1000,
        date: chosenDate
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }


  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (bCtx) {
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Colors.white,
      title: Text('Flutter App',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.blueGrey,
        ),
      ),
    );


    final txListWidget = Container(
        height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
        child: TransactionList(_userTransactions, _deleteTransaction)
    );
    return Scaffold(
      //appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!isLandscape) Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                color: Colors.white,
                height: mediaQuery.size.height * 0.07,
                child: Text('Expense',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
              if (isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(value: _showChart, onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  })
              ],),
              if (!isLandscape) Container(
                  height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                  child: Chart(_recentTransactions)
              ),
              if (!isLandscape) txListWidget,
              if (isLandscape) _showChart? Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                  child: Chart(_recentTransactions)
              ) :
              txListWidget
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)
      ),
    );
  }
}

