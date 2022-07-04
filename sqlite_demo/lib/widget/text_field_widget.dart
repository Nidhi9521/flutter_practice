import 'package:flutter/material.dart';
class TextFieldWid extends StatelessWidget {
  TextEditingController controller=new TextEditingController();
  String text;
  TextFieldWid(this.controller,this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:TextField(
        controller: controller,
        decoration:  InputDecoration(
            labelText:text,
            hintText:text ),
      ),
    );
  }
}
