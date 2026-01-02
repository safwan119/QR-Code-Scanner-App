import 'package:intl/intl.dart';
import 'package:qr_code_scanner/core/util/validators.dart';

class EventController {
  final String startTime, endTime, eventName, eventLocation;

  EventController({
    required this.eventLocation,
    required this.eventName,
    required this.endTime,
    required this.startTime,
  });

  String? validity() {
    final startDateTimeError = Validation.dateTimeValidation("DateTime")(
      startTime,
    );
    if (startDateTimeError != null) {
      return startDateTimeError;
    }
    final endDateTimeError = Validation.dateTimeValidation("DateTime")(endTime);
    if (endDateTimeError != null) {
      return endDateTimeError;
    }
    final DateFormat format =
    DateFormat("dd MMM yyyy, hh:mm a", "en_US");
    final DateTime startDateTime = format.parseStrict(startTime);
    final DateTime endDateTime = format.parseStrict(endTime);
    if (startDateTime.isAtSameMomentAs(endDateTime)) {
      return "Start Date/Time and End Date/Time cannot be the same.";
    }

    if (startDateTime.isAfter(endDateTime)) {
      return "Start Date/Time must be before End Date/Time.";
    }

    final locationTextError = Validation.textValidation("Location")(
      eventLocation,
    );
    if (locationTextError != null) {
      return locationTextError;
    }
    final eventNameTextError = Validation.textValidation("Event Name")(
      eventName,
    );
    if (eventNameTextError != null) {
      return eventNameTextError;
    }
    return null;
  }
}
