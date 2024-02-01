import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      // color: Colors.yellow,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor:const Color.fromRGBO(254, 187, 204, 1),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )
      ),
      child: Text(text), 
      
    );
  }
}