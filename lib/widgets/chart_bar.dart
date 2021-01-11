import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentageOfSpending;

  ChartBar({
    @required this.label,
    @required this.spendingAmount,
    @required this.percentageOfSpending,
  });

  String convertNumber(int value) {
    const units = <int, String>{
      1000000000000000: 'bil',
      1000000000000: 'tril',
      1000000000: 'mil',
      1000000: 'jt',
      1000: 'rb',
    };
    return units.entries
        .map((e) => '${value ~/ e.key}${e.value}')
        .firstWhere((e) => !e.startsWith('0'), orElse: () => '$value');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
                child: Text(
              '${convertNumber(spendingAmount.toInt())}',
              style: TextStyle(fontFamily: 'Quicksand'),
            )),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.50,
            width: constraints.maxWidth * 0.27,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentageOfSpending,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 1),
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Container(
                //   height: 60 * percentageOfSpending,
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.amber, width: 1),
                //     color: Colors.amber,
                //     borderRadius: BorderRadius.circular(2),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                label,
                style: TextStyle(fontFamily: 'Quicksand'),
              ),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.1),
        ],
      );
    });
  }
}
