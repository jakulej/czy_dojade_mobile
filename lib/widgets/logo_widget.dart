import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, this.size = 164});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration:  BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        shape: BoxShape.circle,
      ),
      child:  Center(child: Text('Logo', style: TextStyle(fontSize: size/4),)),
    );
  }
}
