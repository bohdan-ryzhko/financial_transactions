import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final void Function()? onSubmit;
  final String buttonText;

  const SubmitButton({
    Key? key,
    required this.onSubmit,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 25),
          ),
        ),
        child: Text(buttonText, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
