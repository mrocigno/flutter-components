import 'dart:developer' as dev;

import 'package:flutter/material.dart';

class Amount extends StatefulWidget {

  final double amount;
  final double fontSize;

  Amount({
    this.amount,
    this.fontSize = 30
  });

  @override
  AmountState createState() => AmountState();

}

class AmountState extends State<Amount> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(right: widget.fontSize/6, bottom: widget.fontSize/6),
          child: Text("R\$", style: TextStyle(fontSize: widget.fontSize/2)),
        ),
        Text(widget.amount.toStringAsFixed(2).replaceAll(".", ","),
          style: TextStyle(fontSize: widget.fontSize)
        )
      ],
    );
  }
}