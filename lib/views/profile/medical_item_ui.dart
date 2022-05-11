import 'package:checkup/controllers/medical_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class MedicalItemUI extends StatelessWidget {
  const MedicalItemUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalItemController>(
      init: MedicalItemController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              controller.name.capitalize!,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.elements.length,
                  itemBuilder: (_, i) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              controller.elements.value[i] as String,
                              style: const TextStyle(fontSize: 24.0),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextButton.icon(
                              onPressed: () => controller.removeCard(
                                controller.elements[i] as String,
                              ),
                              label: Text(
                                'Remove',
                                style: TextStyle(color: Get.theme.errorColor),
                              ),
                              icon: Icon(
                                UniconsLine.trash,
                                color: Get.theme.errorColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Get.toNamed('/tabbar/profile/medical_item/add_item'),
            child: const Icon(UniconsLine.plus),
          ),
        );
      },
    );
  }
}
