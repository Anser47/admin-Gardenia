import 'package:admin_gardenia/widget/common_widget.dart';
import 'package:flutter/material.dart';

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
                      setState(() {
                        _change = value!;
                      });
                    },
                  ),
                  title: const Text('Last 30 days'),
                ),
                ListTile(
                  leading: Radio<EarningsType>(
                    groupValue: _change,
                    value: EarningsType.last60days,
                    onChanged: (EarningsType? value) {
                      setState(() {
                        _change = value!;
                      });
                    },
                  ),
                  title: const Text('Last 60 days'),
                ),
                ListTile(
                  leading: Radio<EarningsType>(
                    groupValue: _change,
                    value: EarningsType.selectaRange,
                    onChanged: (EarningsType? value) {
                      setState(() {
                        _change = value!;
                      });
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
}
