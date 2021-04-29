import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField(
      {@required this.hint,
      @required this.icon,
      @required this.obscure,
      @required this.stream,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return Form(
          child: TextFormField(
            onChanged: onChanged,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.white70),
                icon: Icon(
                  icon,
                  color: Colors.white70,
                ),
                contentPadding: EdgeInsets.only(
                    bottom: 20.0, right: 20.0, top: 20.0, left: 5.0),
                errorText: snapshot.hasError ? snapshot.error : null,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                )),
            style: TextStyle(
              color: Colors.white,
            ),
            obscureText: obscure,
          ),
        );
      },
    );
  }
}
