import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EarningsScreen extends StatefulWidget {
  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  void _initializeDates() {
    // Initialize dates based on the selected range (e.g., 30 days)
    _selectedEndDate = DateTime.now();
    _selectedStartDate = _selectedEndDate.subtract(Duration(days: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings'),
      ),
      body: Column(
        children: [
          // Widget to allow the user to select the date range
          _buildDateRangeSelector(),
          // Widget to display the earnings based on the selected range
          _buildEarningsList(),
        ],
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Start Date: ${_selectedStartDate.toLocal()}'),
          ElevatedButton(
            onPressed: () => _selectStartDate(context),
            child: Text('Select Start Date'),
          ),
          Text('End Date: ${_selectedEndDate.toLocal()}'),
          ElevatedButton(
            onPressed: () => _selectEndDate(context),
            child: Text('Select End Date'),
          ),
          ElevatedButton(
            onPressed: () => _updateEarnings(),
            child: Text('Update Earnings'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: _selectedEndDate,
    );

    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        _selectedStartDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: _selectedStartDate,
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        _selectedEndDate = pickedDate;
      });
    }
  }

  Widget _buildEarningsList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Order').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // Filter orders based on the selected date range
          List<DocumentSnapshot> orders = snapshot.data!.docs.where((doc) {
            DateTime orderDate = (doc['date'] as Timestamp).toDate();
            return orderDate.isAfter(_selectedStartDate) &&
                orderDate.isBefore(
                  _selectedEndDate.add(Duration(days: 1)),
                );
          }).toList();

          // Calculate total earnings
          double totalEarnings = 0.0;
          for (var order in orders) {
            // Assuming price is stored as a string in the 'price' field
            double orderAmount =
                double.tryParse(order['totalPrice'] ?? '0.0') ?? 0.0;
            totalEarnings += orderAmount;
          }

          // Display earnings information
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total Earnings: ₹$totalEarnings'),
                // Add any additional widgets or information you want to display
              ],
            ),
          );
        },
      ),
    );
  }

  void _updateEarnings() {
    // You can add any additional logic here if needed
    // For example, if you want to fetch data based on the selected range
  }
}
