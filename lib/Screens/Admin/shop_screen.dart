// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:om/Utils/themes.dart';
import '../../Api Service/Admin/shop_service.dart';
import '../../Model/Admin/shop.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopContactController = TextEditingController();
  String? _selectedRouteId;
  bool _isActive = false;
  List<dynamic> _routes = [];
  final ShopService _shopService = ShopService();

  @override
  void initState() {
    super.initState();
    _fetchRoutes();
  }

  Future<void> _fetchRoutes() async {
    try {
      _routes = await _shopService.fetchRoutes('YOUR_API_ENDPOINT_FOR_ROUTES');
      setState(() {});
    } catch (e) {
      print("Error fetching routes: $e");
    }
  }

  Future<void> _saveShop() async {
    final String shopName = _shopNameController.text;
    final String shopContact = _shopContactController.text;

    if (shopName.isNotEmpty &&
        shopContact.isNotEmpty &&
        _selectedRouteId != null) {
      final shop = Shop(
        shopName: shopName,
        shopContact: shopContact,
        routeId: int.parse(_selectedRouteId!),
        isActive: _isActive,
        createdBy: 2,
        updatedBy: 2,
      );

      try {
        await _shopService.saveShop(
            shop, 'http://139.59.7.147:7071/masters/saveShop');
        // Handle success
        print('Shop saved successfully!');
      } catch (e) {
        print("Error saving shop: $e");
      }
    } else {
      print('Please fill all fields.');
    }
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Shop Name Field
                TextField(
                  controller: _shopNameController,
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
                  controller: _shopContactController,
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
                  value: _selectedRouteId,
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
                  items: _routes.map((route) {
                    return DropdownMenuItem<String>(
                      value: route['id'].toString(),
                      child: Text(route['label']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRouteId = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                // Active Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value ?? false;
                        });
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
                  onPressed: _saveShop,
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
            ),
          ),
        ),
      ),
    );
  }
}
