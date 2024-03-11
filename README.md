## Usage

```dart
import 'package:devaloop_data_add_page/data_add_page.dart';
import 'package:devaloop_form_builder/form_builder.dart';
import 'package:devaloop_form_builder/input_field_text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DataAddPage(
        title: 'Add Doctor',
        subtitle: 'Add Doctor',
        inputFields: const [
          InputText(
            name: 'name',
            label: 'Name',
          ),
          InputText(
            name: 'email',
            label: 'Email (Google Account)',
            inputTextMode: InputTextMode.email,
          ),
        ],
        onAfterValidation: (context, inputValues, isValid, erorMessage) {
          if (isValid) {
            if (!inputValues['email']!.getString()!.contains('gmail.com')) {
              erorMessage['email'] = 'Email must an google account (gmail.com)';
            }
          }
        },
        add: (inputValues) => Future(() async {
          // ignore: unused_local_variable
          var name = inputValues['name']!.getString()!;
          // ignore: unused_local_variable
          var email = inputValues['email']!.getString()!;

          await Future.delayed(Durations.extralong4);
        }),
      ),
    );
  }
}
```
