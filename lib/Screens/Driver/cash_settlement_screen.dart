import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/cash_settlement_controller.dart';
import 'package:om/Utils/utils.dart';

class CashSettlementScreen extends StatelessWidget {
  final CashSettlementController controller =
      Get.put(CashSettlementController());

  CashSettlementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: buildAppBar(theme: theme, title: "Settlement"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  boxShadow: [
                    BoxShadow(
                      color: theme.cardTheme.shadowColor!,
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const Text('Settlement Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    (controller.isLoading.value)
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              _buildSettlementRow('Sale',
                                  '${controller.totalSale.value} ₹', theme),
                              _buildSettlementRow('Cash',
                                  '${controller.totalCash.value} ₹', theme),
                              _buildSettlementRow('Online',
                                  '${controller.totalOnline.value} ₹', theme),
                              _buildSettlementRow('Balance',
                                  '${controller.totalBalance.value} ₹', theme),
                              _buildSettlementRow('Personal Expense',
                                  '${controller.totalExpense.value} ₹', theme),
                            ],
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Input fields for notes and coins
              _buildNoteInput(
                  '10 Rs Notes', controller.rs10Notes, context, theme,
                  noteValue: 10),
              _buildNoteInput(
                  '20 Rs Notes', controller.rs20Notes, context, theme,
                  noteValue: 20),
              _buildNoteInput(
                  '50 Rs Notes', controller.rs50Notes, context, theme,
                  noteValue: 50),
              _buildNoteInput(
                  '100 Rs Notes', controller.rs100Notes, context, theme,
                  noteValue: 100),
              _buildNoteInput(
                  '200 Rs Notes', controller.rs200Notes, context, theme,
                  noteValue: 200),
              _buildNoteInput(
                  '500 Rs Notes', controller.rs500Notes, context, theme,
                  noteValue: 500),
              _buildNoteInput(
                  '2000 Rs Notes', controller.rs2000Notes, context, theme,
                  noteValue: 2000),
              _buildNoteInput(
                  'Coins', controller.coins, noteValue: 1, context, theme),

              const SizedBox(height: 20),

              // Display total cash in hand
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount : ',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${controller.totalAmount.value} ₹",
                      style: theme.textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 30),

              // Save button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.calculateTotalInHandCash();
                    controller.saveSettlementData();
                  },
                  style: theme.elevatedButtonTheme.style,
                  child: Text('Save Settlement',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build rows for settlement card
  Widget _buildSettlementRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Helper method to build input fields for each note denomination
  Widget _buildNoteInput(
      String label, RxInt noteController, BuildContext context, ThemeData theme,
      {int noteValue = 0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.13,
              child: Text('$noteValue ₹',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ))),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              child: OmTextField(
                labelText: '$noteValue ₹ Notes',
                hintText: 'Enter number of $noteValue ₹ notes',
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    noteController.value = int.tryParse(value) ?? 0;
                    controller.calculateTotalInHandCash();
                  } else {
                    noteController.value = 0;
                    controller.calculateTotalInHandCash();
                  }
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Obx(() {
            return SizedBox(
                width: MediaQuery.of(context).size.width * 0.13,
                child: Text(
                  '= ₹ ${noteController.value * noteValue}',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ));
          }),
        ],
      ),
    );
  }
}
