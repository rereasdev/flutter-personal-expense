import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Transaksi Kosong!!',
                        style: Theme.of(context).textTheme.headline6.merge(
                              TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                            ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Lottie.asset(
                        'assets/animations/empty-box.json',
                        repeat: true,
                        reverse: false,
                        animate: true,
                        height: MediaQuery.of(context).size.width * 0.40,
                        width: MediaQuery.of(context).size.width * 0.40,
                      ),
                      // Lottie.network(
                      //   'https://assets7.lottiefiles.com/datafiles/vhvOcuUkH41HdrL/data.json',
                      //   repeat: true,
                      //   reverse: false,
                      //   animate: true,
                      // ),
                      // Text(
                      //   'No transaction yet!!',
                      //   style: Theme.of(context).textTheme.headline6.merge(
                      //         TextStyle(
                      //           fontFamily: 'Quicksand',
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      // ),
                      // SizedBox(height: 20),
                      // Container(
                      //     height: constrains.maxHeight * 0.6,
                      //     child: Image.asset(
                      //       'assets/images/waiting.png',
                      //       fit: BoxFit.cover,
                      //     )),
                    ]),
              ),
            );
          })
        : ListView.builder(
            itemCount: userTransactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  leading: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(7),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rp. ',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: '',
                              decimalDigits: 2,
                            ).format(userTransactions[index].amount),
                            style: TextStyle(
                              color: Colors.purple,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: Container(
                    child: Text(
                      userTransactions[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('E, dd MMM y')
                        .format(userTransactions[index].date),
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[300],
                          ),
                          label: Text('Hapus'),
                          textColor: Colors.red[300],
                          onPressed: () =>
                              deleteTransaction(userTransactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[300],
                          ),
                          onPressed: () =>
                              deleteTransaction(userTransactions[index].id),
                        ),
                ),
              );
              // return Card(
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 140,
              //         margin: EdgeInsets.symmetric(
              //           vertical: 10,
              //           horizontal: 10,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Colors.purple,
              //             width: 2,
              //           ),
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //         padding: EdgeInsets.all(7),
              //         child: FittedBox(
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(
              //                 'Rp. ',
              //                 style: TextStyle(
              //                   color: Colors.purple,
              //                   fontWeight: FontWeight.bold,
              //                   fontFamily: 'Quicksand',
              //                 ),
              //               ),
              //               Text(
              //                 NumberFormat.currency(
              //                   locale: 'id_ID',
              //                   symbol: '',
              //                   decimalDigits: 2,
              //                 ).format(userTransactions[index].amount),
              //                 style: TextStyle(
              //                   color: Colors.purple,
              //                   fontFamily: 'Quicksand',
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Container(
              //             width: 100,
              //             child: Text(
              //               userTransactions[index].title,
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 15,
              //                 fontFamily: 'Quicksand',
              //               ),
              //             ),
              //           ),
              //           Text(
              //             DateFormat('E, dd MMM y')
              //                 .format(userTransactions[index].date),
              //             style: TextStyle(
              //               fontSize: 11,
              //               fontFamily: 'Quicksand',
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );
            },
          );
  }
}
