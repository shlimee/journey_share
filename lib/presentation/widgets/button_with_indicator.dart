import 'package:flutter/material.dart';

// https://gist.github.com/NearHuscarl/3a6b9681911072fb53ef9685197c6ba8
// https://stackoverflow.com/a/69424427/9449426

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class ButtonWithIndicator extends StatefulWidget {
  final Text text;
  final Icon icon;
  final Function onSubmit;

  @override
  _ButtonWithIndicatorState createState() => _ButtonWithIndicatorState();

  const ButtonWithIndicator(
      {Key? key,
      required this.text,
      required this.onSubmit,
      required this.icon})
      : super(key: key);
}

class _ButtonWithIndicatorState extends State<ButtonWithIndicator> {
  var _isLoading = false;

  void _onSubmit() {
    setState(() => _isLoading = true);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        widget.onSubmit.call();
        return setState(() => _isLoading = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: _isLoading ? null : _onSubmit,
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(9.0)),
        icon: _isLoading
            ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : widget.icon,
        label: widget.text);
  }
}
