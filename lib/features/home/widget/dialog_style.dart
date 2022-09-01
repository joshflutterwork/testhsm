import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

getLoading(BuildContext context) async {
  final spinkit = SpinKitWave(
    color: Colors.white,
    size: 50.0,
  );
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(child: spinkit);
      });
}

getDialogSuccess(BuildContext context, String? text, bool? isSuccess) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
              decoration: BoxDecoration(color: Colors.white),
              width: 500,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isSuccess!
                      ? Icon(
                          Icons.check_circle_outline_rounded,
                          size: 100,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.error_outline,
                          size: 100,
                          color: Colors.red,
                        ),
                  Text(
                    text!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        );
      });
}
