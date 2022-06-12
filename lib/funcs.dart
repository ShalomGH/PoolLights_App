import 'package:flutter/material.dart';

void Function()? handlePressed(
    BuildContext context, bool isDisabled, String buttonName) {
  return isDisabled
      ? null
      : () {
    final snackBar = SnackBar(
      content: Text(
        'Yay! $buttonName is clicked!',
        style: TextStyle(color: Theme.of(context).colorScheme.surface),
      ),
      action: SnackBarAction(
        textColor: Theme.of(context).colorScheme.surface,
        label: 'Close',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  };
}