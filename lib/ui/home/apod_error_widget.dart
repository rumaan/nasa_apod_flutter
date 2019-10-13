import 'package:flutter/material.dart';

class ApodErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetryClicked;

  ApodErrorWidget({@required this.error, @required this.onRetryClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/error.png",
            height: 180,
            width: 180,
          ),
          SizedBox(height: 32),
          Text(
            "Some Thing is Wrong",
            style: Theme.of(context).textTheme.title.copyWith(color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.black54),
            ),
          ),
          ButtonTheme(
            minWidth: (MediaQuery.of(context).size.width / 8) * 3.5,
            height: 48,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(64),
            ),
            child: RaisedButton(
              onPressed: onRetryClicked,
              textTheme: ButtonTextTheme.primary,
              child: Text(
                "TRY AGAIN",
                maxLines: 1,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
