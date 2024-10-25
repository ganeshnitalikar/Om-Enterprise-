import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/shop_controller.dart';

class ShopScreen extends StatelessWidget {
  final ShopController controller = Get.put(ShopController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.blueAccent;
    final Color secondaryColor = Colors.white;
    final double borderRadius = 12.0;
    final double elevation = 5.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Management'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<ShopController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Shop Name Field
                    TextField(
                      controller: controller.shopNameController,
                      decoration: InputDecoration(
                        labelText: 'Shop Name',
                        labelStyle: TextStyle(color: primaryColor),
                        filled: true,
                        fillColor: secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(color: primaryColor, width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Shop Contact Field
                    TextField(
                      controller: controller.shopContactController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Shop Contact',
                        labelStyle: TextStyle(color: primaryColor),
                        filled: true,
                        fillColor: secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(color: primaryColor, width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Route Dropdown
                    DropdownButtonFormField<String>(
                      value: controller.selectedRouteId,
                      hint: Text('Select Route'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(color: primaryColor, width: 2.0),
                        ),
                      ),
                      items: controller.routes.map((route) {
                        return DropdownMenuItem<String>(
                          value: route['id'].toString(),
                          child: Text(route['label'], style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedRouteId = value;
                      },
                    ),
                    SizedBox(height: 16),
                    // Active Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: controller.isActive,
                          onChanged: (value) {
                            controller.isActive = value ?? false;
                            controller.update(); // Update the state
                          },
                          activeColor: primaryColor,
                        ),
                        Text(
                          'Is Active',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Save Button
                    ElevatedButton(
                      onPressed: controller.saveShop,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      child: Text(
                        'Save Shop',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
