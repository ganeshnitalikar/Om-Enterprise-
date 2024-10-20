// route_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/route_controller.dart';

class RouteView extends StatelessWidget {
  final RouteController _controller = Get.put(RouteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Route Name'),
              onChanged: _controller.setRouteName,
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _controller.isActive.value,
                    onChanged: (value) {
                      _controller.toggleIsActive(value!);
                    },
                  ),
                  Text('Is Active'),
                ],
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.saveRoute();
              },
              child: Text('Save Route'),
            ),
          ],
        ),
      ),
    );
  }
}
