import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../models/prescription_model/prescription_model.dart';
import '../../../services/firestore.dart';

class ViewPrescriptionController extends GetxController {

  var isLoading = false.obs;
  RxList<PrescriptionModel> prescriptions = <PrescriptionModel>[].obs;

  @override
  Future<void> onInit() async {
    await getPrescriptions();
    super.onInit();
  }

  Future<void> getPrescriptions() async {
    prescriptions.clear();
    isLoading.value = true;
    var pillsReminder = FirebaseFireStore.to.getAllPrescriptions();
    pillsReminder.listen((snapshot) {
      for (var pill in snapshot.docChanges) {
        switch (pill.type) {
          case DocumentChangeType.added:
            prescriptions.add(PrescriptionModel.fromJson(pill.doc.data()!));
            break;
          case DocumentChangeType.modified:
          // TODO: Handle this case.
            break;
          case DocumentChangeType.removed:
          // TODO: Handle this case.
            break;
        }
      }
      isLoading.value = false;
    });
  }
}