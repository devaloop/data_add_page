library devaloop_data_add_page;

import 'package:devaloop_form_builder/form_builder.dart';
import 'package:flutter/material.dart';

class DataAddPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Input> inputFields;
  final dynamic Function(Map<String, InputValue> inputValues) add;
  final Function(BuildContext context, Map<String, InputValue> inputValues)?
      onInitial;
  final dynamic Function(
      BuildContext context,
      Map<String, InputValue> inputValues,
      bool isValid,
      Map<String, String?> errorMessages)? onAfterValidation;
  final dynamic Function(
          BuildContext context, Map<String, InputValue> inputValues)?
      onBeforeValidation;
  final dynamic Function(
      BuildContext context,
      Input input,
      dynamic previousValue,
      dynamic currentValue,
      Map<String, InputValue> inputValues)? onValueChanged;
  final bool? isFormEditable;
  final List<AdditionalButton>? additionalButtons;

  const DataAddPage(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.inputFields,
      required this.add,
      this.onInitial,
      this.onAfterValidation,
      this.onBeforeValidation,
      this.onValueChanged,
      this.isFormEditable,
      this.additionalButtons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: FormBuilder(
            inputFields: inputFields,
            onInitial: onInitial,
            onAfterValidation: onAfterValidation,
            onBeforeValidation: onBeforeValidation,
            onValueChanged: onValueChanged,
            isFormEditable: isFormEditable,
            additionalButtons: additionalButtons,
            resetToInitialAfterSubmit: true,
            onSubmit: (context, inputValues) async {
              var result = await add.call(inputValues);

              if (!context.mounted) return;

              var confirm = await showDialog<String>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    icon: const Icon(Icons.info),
                    title: const Text('Data successfully added.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Add Another'),
                        onPressed: () {
                          Navigator.of(context).pop('Add Another');
                        },
                      ),
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop('Ok');
                        },
                      ),
                    ],
                  );
                },
              );

              if (confirm == 'Ok') {
                if (!context.mounted) return;
                Navigator.pop(context, result);
              }
            },
            submitButtonSettings: const SubmitButtonSettings(
              label: 'Add',
              icon: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
