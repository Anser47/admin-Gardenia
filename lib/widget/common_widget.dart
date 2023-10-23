import 'package:flutter/material.dart';

final kSize20 = SizedBox(
  height: 20,
);

class CommonButton extends StatelessWidget {
  CommonButton({super.key, required this.name, required this.voidCallback});
  final String name;
  VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        voidCallback();
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        minimumSize: MaterialStateProperty.all<Size>(const Size(350, 60)),
      ),
      child: Text(
        name,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

/*===================================
Text Field

============================================*/
class CommonTextFields extends StatelessWidget {
  const CommonTextFields({
    super.key,
    required TextEditingController nameControllor,
    required this.labelText,
    required this.validator,
    required this.inputType,
  }) : _nameControllor = nameControllor;

  final TextEditingController _nameControllor;
  final String labelText;
  final String validator;
  final TextInputType inputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      controller: _nameControllor,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validator;
        }
        return null;
      },
    );
  }
}
