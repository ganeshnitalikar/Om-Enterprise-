import 'package:flutter/material.dart';
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

    if (shopName.isNotEmpty && shopContact.isNotEmpty && _selectedRouteId != null) {
      final shop = Shop(
        shopName: shopName,
        shopContact: shopContact,
        routeId: int.parse(_selectedRouteId!),
        isActive: _isActive,
        createdBy: 2, // Assuming static values; adjust as needed
        updatedBy: 2,
      );

      try {
        await _shopService.saveShop(shop, 'http://139.59.7.147:7071/masters/saveShop');
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _shopNameController,
              decoration: InputDecoration(labelText: 'Shop Name'),
            ),
            TextField(
              controller: _shopContactController,
              decoration: InputDecoration(labelText: 'Shop Contact'),
              keyboardType: TextInputType.phone,
            ),
            DropdownButtonFormField<String>(
              value: _selectedRouteId,
              hint: Text('Select Route'),
              items: _routes.map((route) {
                return DropdownMenuItem<String>(
                  value: route['id'].toString(), // Ensure id is a string
                  child: Text(route['label']), // Adjust according to your API response
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRouteId = value;
                });
              },
            ),
            Row(
              children: [
                Checkbox(
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value ?? false;
                    });
                  },
                ),
                Text('Is Active'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveShop,
              child: Text('Save Shop'),
            ),
          ],
        ),
      ),
    );
  }
}
