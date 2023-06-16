import 'package:benaiah_admin_app/core/components/decimal_formatter.dart';
import 'package:benaiah_admin_app/core/extensions/iterable_extensions.dart';
import 'package:benaiah_admin_app/core/widgets/input_field.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/app/dashboard_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/widgets/image_receiver.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/widgets/images.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/widgets/section.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/widgets/weight_unit_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondColumn extends StatefulWidget {
  const SecondColumn({super.key});

  @override
  State<SecondColumn> createState() => _SecondColumnState();
}

class _SecondColumnState extends State<SecondColumn> {
  final weightUnitController = TextEditingController(text: 'kg');
  final weightUnitFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Section(
          padding: const EdgeInsets.all(20).copyWith(right: 1),
          title: 'Images',
          children: const [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageReceiver(),
                SizedBox(width: 10),
                Expanded(child: Images()),
              ],
            ),
          ],
        ),
        Section(
          title: 'Shipping and Delivery',
          children: [
            ListenableBuilder(
              listenable: weightUnitController,
              builder: (_, __) {
                return InputField(
                  label: "Item's Weight",
                  focusNode: weightUnitFocusNode,
                  suffixText: weightUnitController.text,
                  suffixIcon: WeightUnitDropdown(
                    controller: weightUnitController,
                    focusNode: weightUnitFocusNode,
                  ),
                  inputFormatters: [
                    DecimalFormatter(),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Package Size(Dimensions of the package which will be used to'
              ' ship the item)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                  label: 'Length',
                  required: false,
                  maxWidth: 150,
                  minWidth: 150,
                  suffixText: 'in',
                  inputFormatters: [
                    DecimalFormatter(),
                  ],
                ),
                const SizedBox(width: 10),
                InputField(
                  label: 'Width',
                  required: false,
                  maxWidth: 150,
                  minWidth: 150,
                  suffixText: 'in',
                  inputFormatters: [
                    DecimalFormatter(),
                  ],
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: InputField(
                    label: 'Height',
                    required: false,
                    maxWidth: 150,
                    minWidth: 150,
                    suffixText: 'in',
                    inputFormatters: [
                      DecimalFormatter(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Section(
          title: 'Pricing',
          children: [
            Builder(
              builder: (context) {
                final prefixIcon = Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300],
                  ),
                  child: Icon(Icons.currency_pound, color: Colors.grey[600]),
                );
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputField(
                      label: 'Price',
                      required: false,
                      maxWidth: 200,
                      minWidth: 200,
                      prefixIcon: prefixIcon,
                      inputFormatters: [
                        DecimalFormatter(),
                      ],
                    ),
                    const SizedBox(width: 10),
                    InputField(
                      label: 'Compare at Price',
                      required: false,
                      maxWidth: 200,
                      minWidth: 200,
                      prefixIcon: prefixIcon,
                      inputFormatters: [
                        DecimalFormatter(),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                context.read<DashboardController>().pop();
              },
              child: const Text(
                'Discard',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    foregroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    var selectedDate = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    } else {
                      return;
                    }
                    if(!mounted) return;
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      });
                    }
                    debugPrint('selectedDate: $selectedDate');
                  },
                  child: const Text('Schedule'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Add '
                      'Product'),
                ),
              ],
            ),
          ],
        ),
      ].columnGap(35),
    );
  }
}
