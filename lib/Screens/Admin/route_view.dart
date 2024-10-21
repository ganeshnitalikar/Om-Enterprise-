<<<<<<< HEAD
// route_view.dart
// ignore_for_file: deprecated_member_use

=======
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Utils/themes.dart';
import '../../Controllers/Admin/route_controller.dart';

class RouteView extends StatelessWidget {
  final RouteController _controller = Get.put(RouteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('Route Management',style: Themes.light.textTheme.headlineSmall,),
        backgroundColor: Themes.light.colorScheme.background
=======
        title: Text(
          'Route Management',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Route',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // Route Name Input Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Route Name',
                labelStyle: TextStyle(color: Colors.blueAccent),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
              onChanged: _controller.setRouteName,
            ),
            SizedBox(height: 20),

            // Is Active Checkbox
            Obx(() {
              return Row(
                children: [
                  Checkbox(
                    value: _controller.isActive.value,
                    onChanged: (value) {
                      _controller.toggleIsActive(value!);
                    },
                    activeColor: Colors.blueAccent,
                  ),
                  Text(
                    'Is Active',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              );
            }),

            // Save Button
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _controller.saveRoute();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save Route',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing at the bottom
          ],
        ),
      ),
    );
  }
}
