import 'package:flutter/material.dart';

class BackdropComponent extends StatelessWidget {
  final Widget component;

  const BackdropComponent({
    Key? key,
    required this.component,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: component,
          ),
        ),
      ),
    );
  }
}
