import 'package:flutter/material.dart';

class OrderIcon extends StatelessWidget {
  const OrderIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10), child: Center(child: Icon(Icons.notifications, size: 30, color: Colors.white,))),
        Positioned(
          bottom: 30,
          left: 24,
          child: CircleAvatar(
            maxRadius: 10,
            backgroundColor: Colors.orange.withOpacity(0.8),
            child: Center(child: Text('1',style: TextStyle(color: Colors.white),)),
          ),
        ),
      ],
    );
  }
}
