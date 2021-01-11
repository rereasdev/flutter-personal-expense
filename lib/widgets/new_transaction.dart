import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransactionHandler;

  NewTransaction(this.addNewTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // String titleInput;
  // double amountInput;
  final _inputTitleController = TextEditingController();
  final _inputAmountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_inputAmountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _inputTitleController.text;
    final enteredAmount = double.parse(_inputAmountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransactionHandler(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), //DateTime.now().year
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        margin: EdgeInsets.only(
          right: 20,
          top: 0,
          left: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Judul',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Masukkan Judul',
                hintStyle: TextStyle(color: Colors.white60),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              controller: _inputTitleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => titleInput = val,
            ),
            TextField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Jumlah',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Masukkan Jumlah',
                hintStyle: TextStyle(color: Colors.white60),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: _inputAmountController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = double.parse(val),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
              child:
                  // Expanded(
                  //   child: Text(
                  //     _selectedDate == null
                  //         ? 'Tanggal Kosong'
                  //         : DateFormat('E, dd MMM y').format(_selectedDate),
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                  FlatButton(
                padding: EdgeInsets.only(left: 0),
                textColor: Theme.of(context).primaryColor,
                onPressed: _presentDatePicker,
                child: Text(
                  _selectedDate == null
                      ? 'Pilih Tanggal'
                      : DateFormat('E, dd MMM y').format(_selectedDate),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: RaisedButton(
                onPressed: _submitData,
                child: Text(
                  'Tambah',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                textColor: Theme.of(context).accentColor,
              ),
              // OutlineButton(
              //   onPressed: _submitData,
              //   child: Text('Tambah'),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              //   textColor: Theme.of(context).primaryColor,
              //   borderSide: BorderSide(
              //     color: Theme.of(context).primaryColor,
              //     width: 1,
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
