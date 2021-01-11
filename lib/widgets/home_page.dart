import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/list_transaction.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Kalung',
    //   amount: 700000,
    //   // date: DateTime.parse("2021-01-05"),
    //   date: DateTime.now().subtract(Duration(days: 6)),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Sempak',
    //   amount: 6000000,
    //   // date: DateTime.parse("2021-01-04"),
    //   date: DateTime.now().subtract(Duration(days: 5)),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Galon',
    //   amount: 100000,
    //   // date: DateTime.parse("2021-01-04"),
    //   date: DateTime.now().subtract(Duration(days: 5)),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'Kaos',
    //   amount: 800000,
    //   // date: DateTime.parse("2021-01-07"),
    //   date: DateTime.now().subtract(Duration(days: 4)),
    // ),
    // Transaction(
    //   id: 't5',
    //   title: 'Jaket',
    //   amount: 300000,
    //   // date: DateTime.parse("2021-01-08"),
    //   date: DateTime.now().subtract(Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't6',
    //   title: 'Tas',
    //   amount: 800000,
    //   // date: DateTime.parse("2021-01-02"),
    //   date: DateTime.now().subtract(Duration(days: 2)),
    // ),
    // Transaction(
    //   id: 't7',
    //   title: 'Gitar',
    //   amount: 200000,
    //   // date: DateTime.parse("2021-01-07"),
    //   date: DateTime.now().subtract(Duration(days: 1)),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txtDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: txtDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
        enableDrag: true,
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expense',
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Chart'),
                      Switch.adaptive(
                          activeColor: Colors.white,
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          }),
                    ],
                  ),
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startNewTransaction(context),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Personal Expense',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chart'),
                    Switch.adaptive(
                        activeColor: Colors.white,
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        })
                  ],
                ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startNewTransaction(context),
              )
            ],
          );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Show Chart'),
            //       Switch(
            //           value: _showChart,
            //           onChanged: (val) {
            //             setState(() {
            //               _showChart = val;
            //             });
            //           })
            //     ],
            //   ),
            if (!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransaction)),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransaction))
                  : Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          1,
                      child: TransactionList(
                          _userTransactions, _deleteTransaction),
                    ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Theme.of(context).accentColor,
                    child: Icon(Icons.add),
                    onPressed: () => _startNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
