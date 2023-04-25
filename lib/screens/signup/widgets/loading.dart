import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SpinKitWanderingCubes(
            color: Colors.white,
            size: 25.0,
          ),
        ),
      ),
    );
  }
}
