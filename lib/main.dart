import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

main() => runApp(MyApp());

// void main()  {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]).then((_) => runApp(MyApp()));
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            // title: "Personal Expenses",
            // theme: CupertinoThemeData(
            //     primarySwatch: Colors.pink,
            //     accentColor: Colors.pinkAccent,
            //     // errorColor: Colors.red,
            //     fontFamily: 'Quicksand',
            //     textTheme: ThemeData.light().textTheme.copyWith(
            //         title: TextStyle(
            //           fontFamily: 'OpenSans',
            //           fontWeight: FontWeight.bold,
            //           fontSize: 18,
            //         ),
            //         button: TextStyle(
            //           color: Colors.white,
            //         )),
            //     appBarTheme: AppBarTheme(
            //       textTheme: ThemeData.light().textTheme.copyWith(
            //             title: TextStyle(
            //               fontFamily: 'OpenSans',
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //     )),
            // home: PersonalExpenseApp(),

            //NOTE: Needs to be explored...
            )
        : MaterialApp(
            title: "Personal Expenses",
            theme: ThemeData(
                primarySwatch: Colors.pink,
                accentColor: Colors.pinkAccent,
                // errorColor: Colors.red,
                fontFamily: 'Quicksand',
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    button: TextStyle(
                      color: Colors.white,
                    )),
                appBarTheme: AppBarTheme(
                  textTheme: ThemeData.light().textTheme.copyWith(
                        title: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                )),
            home: PersonalExpenseApp(),
          );
  }
}

class PersonalExpenseApp extends StatefulWidget {
  @override
  _PersonalExpenseAppState createState() => _PersonalExpenseAppState();
}

class _PersonalExpenseAppState extends State<PersonalExpenseApp>
    with WidgetsBindingObserver /* Should always be added in state class */ {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Breakfast',
    //   amount: 60.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Load',
    //   amount: 50.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Dinner',
    //   amount: 75.00,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override // Called when the reaches new life cycle
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // setState(() { _notification = state; });
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList(); // Since it returns an Iterable by default
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bContext) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  Widget _buildLandscapeContent() {/* Alternative Approach instead... */}

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget transactionListWiget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      transactionListWiget
    ];
  }

  Widget _buildCupertinoNavBar() {
    return CupertinoNavigationBar(
      middle: const Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Personal Expenses',
        style: const TextStyle(
          fontFamily: 'OpenSans',
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildCupertinoNavBar() : _buildAppBar();

    final transactionListWiget = Container(
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appBar.preferredSize.height) *
          0.70,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!isLandscape)
              ..._buildPortraitContent(
                  mediaQuery, appBar, transactionListWiget),
            if (isLandscape) ...[
              // Can be implented in using builderMethod
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _showChart,
                      onChanged: (newValue) {
                        setState(() {
                          _showChart = newValue;
                        });
                      }),
                ],
              ),
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              mediaQuery.padding.top -
                              appBar.preferredSize.height) *
                          0.67,
                      child: Chart(_recentTransactions),
                    )
                  : transactionListWiget,
            ]
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? null //Renders nothing if on IOS device
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
