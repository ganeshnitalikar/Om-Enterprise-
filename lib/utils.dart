import 'package:flutter/material.dart';

Widget submitButton({required String text, required Function onPressed}) {
  return GestureDetector(
    onTap: () {
      onPressed();
    },
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}

Widget myTextField(BuildContext context,
    {required String label, required TextEditingController controller}) {
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      height: 49,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * .9,
      decoration: const BoxDecoration(),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: label,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color.fromRGBO(0, 0, 0, 0.4))),
      ),
    ),
  );
}

Widget pickMediaButton({required Function onPressed, required String text}) {
  return GestureDetector(
    onTap: () {
      onPressed();
    },
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}

Widget inputField(
    {required String labelText,
    required TextEditingController controller,
    required TextInputType keyboardType}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );
}
