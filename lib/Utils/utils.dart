import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:om/Services/api_service.dart';

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

Widget OmTextField({
  required String labelText,
  required String hintText,
  required Function(String) onChanged,
  required TextInputType keyboardType,
}) {
  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      labelText: labelText,
      hintText: hintText,
      filled: true,
      fillColor: Colors.blue[50],
    ),
    keyboardType: keyboardType,
    onChanged: onChanged,
  );
}

AppBar buildAppBar({
  required ThemeData theme,
  required String title,
}) {
  return AppBar(
    backgroundColor: theme.appBarTheme.backgroundColor,
    centerTitle: true,
    title: Text(
      title,
      style: theme.appBarTheme.titleTextStyle!.copyWith(
        color: theme.appBarTheme.titleTextStyle!.color,
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.logout,
          color: theme.iconTheme.color,
        ),
        onPressed: () {
          Get.dialog(Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Are you sure you want to logout?",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          APIService().logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.error,
                        ),
                        child: Text("Yes",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: theme.canvasColor)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: theme.elevatedButtonTheme.style,
                        child: Text(
                          "No",
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    ],
  );
}
