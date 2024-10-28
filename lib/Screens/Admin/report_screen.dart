import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/report_controller.dart';

class ReportScreen extends StatelessWidget {
  final ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildButtonColumn(),
            Obx(() => controller.selectedReport.value == 'Balance Report'
                ? _buildBalanceReportForm()
                : Container()),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonColumn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildReportButton('Balance Report'),
        _buildReportButton('Sale Report'),
        _buildReportButton('Expense Report'),
        _buildReportButton('Expiry Report'),
      ],
    );
  }

  Widget _buildReportButton(String title) {
    return ElevatedButton(
      onPressed: () {
        controller.selectedReport.value = title;
      },
      child: Text(title),
    );
  }

  Widget _buildBalanceReportForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildDatePickerField('From Date', onDateSelected: (date) {
                  controller.fromDate.value = date.toString().split(' ')[0];
                }),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildDatePickerField('To Date', onDateSelected: (date) {
                  controller.toDate.value = date.toString().split(' ')[0];
                }),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildDropdown('Shop Dropdown')),
              SizedBox(width: 10),
              Expanded(child: _buildDropdown('Employee Dropdown')),
              SizedBox(width: 10),
              Expanded(child: _buildStaticDropdown()),
            ],
          ),
          SizedBox(height: 20),
          _buildReportTable(),
        ],
      ),
    );
  }

  Widget _buildDatePickerField(String label, {required Function(DateTime) onDateSelected}) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
        border: OutlineInputBorder(),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black),
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          onDateSelected(pickedDate);
        }
      },
    );
  }

  Widget _buildDropdown(String label) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      items: [
        DropdownMenuItem(child: Text('Option 1', style: TextStyle(color: Colors.black)), value: '1'),
        DropdownMenuItem(child: Text('Option 2', style: TextStyle(color: Colors.black)), value: '2'),
      ],
      onChanged: (value) {
        // Handle dropdown value change
      },
    );
  }

  Widget _buildStaticDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Status'),
      items: [
        DropdownMenuItem(child: Text('Pending', style: TextStyle(color: Colors.black)), value: 'Pending'),
        DropdownMenuItem(child: Text('Complete', style: TextStyle(color: Colors.black)), value: 'Complete'),
      ],
      onChanged: (value) {
        // Handle static dropdown value change
      },
    );
  }

  Widget _buildReportTable() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => _showDetailsDialog(context, index),
          child: Card(
            child: ListTile(
              title: Text('Shop Name ${index + 1}', style: TextStyle(color: Colors.black)),
              subtitle: Text('Shop Contact ${index + 1}', style: TextStyle(color: Colors.black)),
              trailing: Text('\$${(index + 1) * 100}', style: TextStyle(color: Colors.black)),
            ),
          ),
        );
      },
    );
  }

  void _showDetailsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Shop Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Shop Name: Shop Name ${index + 1}'),
                Text('Shop Contact: Shop Contact ${index + 1}'),
                Text('Employee Name: Employee Name'),
                Text('Balance Amount: \$${(index + 1) * 100}'),
                Text('Balance Date: 2024-10-23'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
