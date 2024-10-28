import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/report_controller.dart';
import 'package:om/Utils/utils.dart';

class ReportScreen extends StatelessWidget {
  final ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: buildAppBar(theme: theme, title: "Reports"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildButtonColumn(),
            Obx(() => controller.selectedReport.value == 'Balance Report'
                ? BalanceReportForm(controller: controller)
                : Container()),
            ReportList(controller: controller),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonColumn() {
    final reports = ['Balance Report', 'Sale Report', 'Expense Report', 'Expiry Report'];
    return Column(
      children: reports.map((title) => _buildReportButton(title)).toList(),
    );
  }

  Widget _buildReportButton(String title) {
    return ElevatedButton(
      onPressed: () => controller.selectedReport.value = title,
      child: Text(title),
    );
  }
}

class BalanceReportForm extends StatelessWidget {
  final ReportController controller;
  const BalanceReportForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDateRangePicker(),
          const SizedBox(height: 7),
          _buildDropdownRow(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.fetchReports,
            child: Text('Generate Report'),
          ),
          const SizedBox(height: 20),
          ReportTable(controller: controller),
        ],
      ),
    );
  }

  Widget _buildDateRangePicker() {
    return Row(
      children: [
        Expanded(child: _buildDatePickerField('From Date', controller.fromDate)),
        SizedBox(width: 10),
        Expanded(child: _buildDatePickerField('To Date', controller.toDate)),
      ],
    );
  }

  Widget _buildDatePickerField(String label, RxString date) {
    return TextField(
      readOnly: true,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          date.value = '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
          print('$label selected date: ${date.value}'); // Debugging output
        }
      },
    );
  }

  Widget _buildDropdownRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildDropdown('Shop', controller.shopId, controller.shopDropdownItems),
        ),
        SizedBox(width: 1),
        Expanded(
          child: _buildDropdown('Employee', controller.driverId, controller.employeeDropdownItems),
        ),
        SizedBox(width: 1),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Status',
              isDense: true,
            ),
            style: TextStyle(fontSize: 14),
            items: [
              DropdownMenuItem(
                child: Text('Pending', style: TextStyle(fontSize: 10, color: Colors.black)),
                value: 'Pending',
              ),
              DropdownMenuItem(
                child: Text('Complete', style: TextStyle(fontSize: 10, color: Colors.black)),
                value: 'Complete',
              ),
            ],
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, RxInt selectedId, List<DropdownItem> items) {
    return Obx(() => DropdownButtonFormField<int>(
      value: items.isNotEmpty && items.any((item) => item.id == selectedId.value)
          ? selectedId.value
          : null,
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
      ),
      style: TextStyle(fontSize: 9.5),
      items: items.isNotEmpty
          ? items.map((item) {
              return DropdownMenuItem<int>(
                value: item.id,
                child: Text(item.label, style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis),
              );
            }).toList()
          : [
              DropdownMenuItem<int>(
                value: 0,
                child: Text('No', style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis),
              ),
            ],
      onChanged: (value) => selectedId.value = value ?? 0,
    ));
  }
}

class ReportTable extends StatelessWidget {
  final ReportController controller;
  const ReportTable({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.reportData.length,
      itemBuilder: (context, index) {
        final report = controller.reportData[index];
        return InkWell(
          onTap: () => _showDetailsDialog(context, report),
          child: Card(
            child: ListTile(
              title: Text(report['shopName']),
              subtitle: Text(report['shopContact']),
              trailing: Text('\$${report['balance']}'),
            ),
          ),
        );
      },
    ));
  }

  void _showDetailsDialog(BuildContext context, dynamic report) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Shop Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shop Name: ${report['shopName']}'),
              Text('Shop Contact: ${report['shopContact']}'),
              Text('Employee Name: ${report['employeeName']}'),
              Text('Balance Amount: \$${report['balance']}'),
              Text('Balance Date: ${report['date']}'),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
          ],
        );
      },
    );
  }
}

class ReportList extends StatelessWidget {
  final ReportController controller;
  const ReportList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.reportData.length,
      itemBuilder: (context, index) {
        final report = controller.reportData[index];
        return ListTile(
          title: Text('Shop Name: ${report['shopName']}'),
          subtitle: Text('Balance: \$${report['balance']}'),
        );
      },
    ));
  }
}
