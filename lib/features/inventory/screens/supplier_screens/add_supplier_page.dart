import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/action_button.dart';
import '../../models/supplier.dart';
import '../../providers/supplier_provider.dart';
import '../widgets/supplier_form.dart';

class AddSupplierPage extends ConsumerStatefulWidget {
  const AddSupplierPage({super.key});

  @override
  ConsumerState<AddSupplierPage> createState() => _AddSupplierPageState();
}

class _AddSupplierPageState extends ConsumerState<AddSupplierPage> {
  bool _isAdding = false;
  final GlobalKey<SupplierFormCardState> supplierFormKey = GlobalKey<SupplierFormCardState>();

  Supplier _supplier = Supplier(
    name: '',
    description: '',
    logourl: '',
    website: '',
    countryOfOrigin: '',
    socialMediaLinks: '',
    contactEmail: '',
    phoneNumber: '',
    bannerUrl: '',
    locatedCity: '',
    locatedCountry: '',
    bankDetails: '',
    status: '',
    extraData: '',
  );

  Future<void> _addSupplier(Supplier newSupplier) async {
    setState(() {
      _isAdding = true;
    });

    try {
      await ref.read(supplierNotifierProvider.notifier).addSupplier(newSupplier);
      ref.invalidate(supplierNotifierProvider);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding supplier: $e')),
      );
    } finally {
      setState(() {
        _isAdding = false;
      });

      supplierFormKey.currentState?.clearFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    final suppliersAsync = ref.watch(supplierNotifierProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenwidth = MediaQuery.of(context).size.width;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                suppliersAsync.when(
                  data: (suppliers) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: suppliers.map((s) {
                        return Chip(
                          label: Text(
                            s.name,
                            style: const TextStyle(fontSize: 12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        );
                      }).toList(),
                    ),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text('Error: $e'),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: screenwidth / 2.9,
                  child: SupplierFormCard(
                    key: supplierFormKey,
                    newSupplier: _supplier,
                    onSupplierChanged: (updated) {
                      setState(() {
                        _supplier = updated;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ActionButton(
                  onPressed: () => _addSupplier(_supplier),
                  icon: const SizedBox.shrink(),
                  label: Text(
                    'Add Supplier',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
