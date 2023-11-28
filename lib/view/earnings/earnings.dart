import 'package:admin_gardenia/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

enum EarningsType { last30days, last60days, selectaRange }

class ScreenEarnings extends StatefulWidget {
  const ScreenEarnings({super.key});

  @override
  State<ScreenEarnings> createState() => _ScreenEarningsState();
}

class _ScreenEarningsState extends State<ScreenEarnings> {
  EarningsType _change = EarningsType.last30days;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Earnings',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          kHeight20,
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    height: size.height / 7,
                    child: const Center(
                      child: Text(
                        'Total: \$4092',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Radio<EarningsType>(
                    groupValue: _change,
                    value: EarningsType.last30days,
                    onChanged: (EarningsType? value) {
                      setState(
                        () {
                          _change = value!;
                        },
                      );
                    },
                  ),
                  title: const Text('Last 30 days'),
                ),
                ListTile(
                  leading: Radio<EarningsType>(
                    groupValue: _change,
                    value: EarningsType.last60days,
                    onChanged: (EarningsType? value) {
                      setState(
                        () {
                          _change = value!;
                        },
                      );
                    },
                  ),
                  title: const Text('Last 60 days'),
                ),
                ListTile(
                  leading: Radio<EarningsType>(
                    groupValue: _change,
                    value: EarningsType.selectaRange,
                    onChanged: (EarningsType? value) {
                      setState(
                        () {
                          _change = value!;
                        },
                      );
                      _navigateToEarningsScreen();
                    },
                  ),
                  title: const Text('Select a range'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEarningsScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EarningsScreen(selectedType: _change),
    ));
  }
}

class EarningsScreen extends StatefulWidget {
  final EarningsType selectedType;

  const EarningsScreen({Key? key, required this.selectedType})
      : super(key: key);

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
    _selectedStartDate = _selectedEndDate.subtract(
      const Duration(days: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Widget to allow the user to select the date range
            _buildDateRangeSelector(),
            // Widget to display the earnings based on the selected range
            _buildEarningsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            kHeight30,
            Text(
              'Start Date: ${_formatDate(_selectedStartDate)}',
              style: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 30,
              ),
            ),
            kHeight20,
            ElevatedButton(
              onPressed: () => _selectStartDate(context),
              child: const Text(
                'Select Start Date',
              ),
            ),
            Text(
              'End Date:\n ${_selectedEndDate.toLocal()}',
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            kHeight30,
            ElevatedButton(
              onPressed: () => _selectEndDate(context),
              child: const Text('Select End Date'),
            ),
            ElevatedButton(
              onPressed: () => _updateEarnings(),
              child: const Text('Update Earnings'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Format the date using intl package
    return DateFormat.yMd().format(date);
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

  DateTime _getOrderDate(dynamic date) {
    if (date is String) {
      // Adjust the format according to how you store dates in Firestore
      // For example, if dates are stored as 'yyyy-MM-dd', you can use the format 'yyyy-MM-dd'
      try {
        return DateTime.parse(date);
      } catch (e) {
        print('Error parsing date: $e');
        // Handle parsing error or provide a default value
        return DateTime.now();
      }
    } else if (date is Timestamp) {
      return date.toDate();
    } else {
      // Handle other cases if necessary
      return DateTime.now(); // Provide a default value or handle accordingly
    }
  }

  Widget _buildEarningsList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Order').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Filter orders based on the selected date range
          List<DocumentSnapshot> orders = snapshot.data!.docs.where(
            (doc) {
              DateTime orderDate = _getOrderDate(doc['date']);
              return orderDate.isAfter(_selectedStartDate) &&
                  orderDate.isBefore(
                    _selectedEndDate.add(
                      const Duration(days: 1),
                    ),
                  );
            },
          ).toList();

          // Calculate total earnings
          double totalEarnings = 0.0;
          for (var order in orders) {
            // Assuming totalPrice is stored as a string in the 'totalPrice' field
            double orderAmount =
                double.tryParse(order['totalPrice'] ?? '0.0') ?? 0.0;
            totalEarnings += orderAmount;
          }

          // Display earnings information
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Earnings: ${totalEarnings.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
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
