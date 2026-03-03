import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _originalPriceController;
  late final TextEditingController _discountController;
  late final FocusNode _discountFocusNode;
  double _finalPrice = 0;
  double _savings = 0;

  void _calculateDiscount([double? discountPercent]) {
    final originalPrice = double.tryParse(_originalPriceController.text) ?? 0;
    final discount =
        discountPercent ?? (double.tryParse(_discountController.text) ?? 0);

    setState(() {
      _savings = (originalPrice * discount) / 100;
      _finalPrice = originalPrice - _savings;
      _discountController.text = discount.toStringAsFixed(0);
    });
  }

  @override
  void initState() {
    _originalPriceController = TextEditingController();
    _discountController = TextEditingController();
    _discountFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _originalPriceController.dispose();
    _discountController.dispose();
    _discountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B132B),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/logo.svg", height: 40),
                    SizedBox(width: 10),
                    const Text(
                      'SwiftSale',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A2847),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Final Price',
                        style: TextStyle(
                          color: Color(0xFFC0C0C0),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${_finalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD4AF37),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'You save \$${_savings.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFF4CAF50),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _originalPriceController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _calculateDiscount(),
                  style: const TextStyle(color: Color(0xFFFFFFFF)),
                  decoration: InputDecoration(
                    hintText: 'Original Price',
                    hintStyle: const TextStyle(color: Color(0xFF7A8CA3)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFC0C0C0)),
                    ),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_discountFocusNode);
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _discountController,
                  focusNode: _discountFocusNode,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _calculateDiscount(),
                  style: const TextStyle(color: Color(0xFFFFFFFF)),
                  decoration: InputDecoration(
                    hintText: 'Discount %',
                    hintStyle: const TextStyle(color: Color(0xFF7A8CA3)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFC0C0C0)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [10, 20, 50]
                      .map(
                        (percent) => InkWell(
                          onTap: () => _calculateDiscount(percent.toDouble()),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFD4AF37),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$percent%',
                                style: const TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
