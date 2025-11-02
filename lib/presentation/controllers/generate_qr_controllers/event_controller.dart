import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/core/util/validators.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../constants/qr_code_outputs.dart';
import '../../../route/routes_name.dart';

class EventController extends RxController {
  String? validity() {
    final startDateTimeError = Validation.dateTimeValidation("DateTime")(
      Controllers.startDateTimeController.text,
    );
    if (startDateTimeError != null) {
      return startDateTimeError;
    }
    final endDateTimeError = Validation.dateTimeValidation("DateTime")(
      Controllers.endDateTimeController.text,
    );
    if (endDateTimeError != null) {
      return endDateTimeError;
    }
    final startDateTime = DateTime.parse(
      Controllers.startDateTimeController.text,
    );
    final endDateTime = DateTime.parse(Controllers.endDateTimeController.text);
    if (startDateTime.isAtSameMomentAs(endDateTime)) {
      return "Start Date/Time and End Date/Time cannot be the same.";
    }

    if (startDateTime.isAfter(endDateTime)) {
      return "Start Date/Time must be before End Date/Time.";
    }

    final locationTextError = Validation.textValidation("Location")(
      Controllers.eventLocationController.text,
    );
    if (locationTextError != null) {
      return locationTextError;
    }
    final eventNameTextError = Validation.textValidation("Location")(
      Controllers.eventNameController.text,
    );
    if (eventNameTextError != null) {
      return eventNameTextError;
    }
    return null;
  }

  void generateEventQr() {
    final eventValidationError = validity();
    if (eventValidationError != null) {
      ShortMessage.showErrorMessage(eventValidationError);
      return;
    }
    final qrData = QrCodeOutputs.eventDetailOutput;
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(qrData)
        .then((value) {
          ShortMessage.showSuccessMessage("Qr Generated Successfully");
        })
        .onError((error, stackTrace) {
          ShortMessage.showErrorMessage(error.toString());
        });
    Get.toNamed(RoutesName.qrCodeScreen, arguments: qrData);
  }
}
