import 'package:benaiah_admin_app/core/components/decimal_formatter.dart';
import 'package:benaiah_admin_app/core/extensions/iterable_extensions.dart';
import 'package:benaiah_admin_app/core/utils/core_utils.dart';
import 'package:benaiah_admin_app/core/widgets/input_field.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/app/dashboard_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/core/app/providers/product_provider.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/add_product_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/category_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/images_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/widgets/image_receiver.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/widgets/images.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/widgets/section.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/widgets/weight_unit_dropdown.dart';
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

  Future<void> addProduct([DateTime? selectedDate]) async {
    if (!context
        .read<AddProductController>()
        .formKey
        .currentState!
        .validate()) {
      return;
    }
    final now = DateTime.now();
    final productProvider = context.read<ProductProvider>();
    final addProductController = context.read<AddProductController>();
    final categoryController = context.read<CategoryController>();
    final imagesController = context.read<ImagesController>();
    if (categoryController.selectedCategories.isEmpty) {
      await CoreUtils.showErrorAlert(
        message: 'Please select at least one category then try again',
      );
      return;
    }
    await productProvider.addProduct(
      addProductController.furniture(
        createdAt: now,
        categories: categoryController.selectedCategories,
        images: imagesController.images.map((e) => e.path).toList(),
        scheduleDate: selectedDate,
      ),
    );
  }

  Future<void> schedule() async {
    if (!context
        .read<AddProductController>()
        .formKey
        .currentState!
        .validate()) {
      return;
    }
    var selectedDate = DateTime.now();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      selectableDayPredicate: (date) => date.isAfter(
        DateTime.now().subtract(const Duration(days: 1)),
      ),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    } else if (picked == null) {
      return;
    }
    if (!mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;
    selectedDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    await addProduct(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddProductController>(
      builder: (_, controller, __) {
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
                      controller: controller.productWeightController,
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
                      controller: controller.productLengthController,
                      required: false,
                      maxWidth: 150,
                      minWidth: 150,
                      suffixText: 'in',
                      validator: controller.lengthValidator,
                      inputFormatters: [
                        DecimalFormatter(),
                      ],
                    ),
                    const SizedBox(width: 10),
                    InputField(
                      label: 'Width',
                      controller: controller.productWidthController,
                      required: false,
                      maxWidth: 150,
                      minWidth: 150,
                      suffixText: 'in',
                      validator: controller.widthValidator,
                      inputFormatters: [
                        DecimalFormatter(),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: InputField(
                        label: 'Height',
                        controller: controller.productHeightController,
                        required: false,
                        maxWidth: 150,
                        minWidth: 150,
                        suffixText: 'in',
                        validator: controller.heightValidator,
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
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[300],
                      ),
                      child:
                          Icon(Icons.currency_pound, color: Colors.grey[600]),
                    );
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InputField(
                          label: 'Price',
                          controller: controller.productPriceController,
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
                          controller:
                              controller.productCompareAtPriceController,
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
                      onPressed: schedule,
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
                      onPressed: addProduct,
                      child: const Text('Add Product'),
                    ),
                  ],
                ),
              ],
            ),
          ].columnGap(35),
        );
      },
    );
  }
}
