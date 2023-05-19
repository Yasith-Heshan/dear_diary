import 'package:flutter/material.dart';

import 'add_card_form.dart';
import 'battery_status.dart';
import 'card_list.dart';
class scrollWidget extends StatelessWidget {
  const scrollWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: BatteryStatus(),
          ),
          AddCardForm(),
          DiaryCardsList()
        ],
      ),
    );
  }
}
