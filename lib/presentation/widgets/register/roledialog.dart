import 'package:flutter/material.dart';


Future<String?> showRadioOptionDialog({
  required BuildContext context,
  required String title,
  required String option1,
  required String option2,
}) {
  String selected = option1;

  return showDialog<String>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  title: Text(option1),
                  value: option1,
                  groupValue: selected,
                  onChanged: (value) {
                    setState(() {
                      selected = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text(option2),
                  value: option2,
                  groupValue: selected,
                  onChanged: (value) {
                    setState(() {
                      selected = value!;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // cancelar
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, selected),
                child: const Text("Aceptar"),
              ),
            ],
          );
        },
      );
    },
  );
}
