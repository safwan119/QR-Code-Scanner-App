import 'package:get/get.dart';
import 'package:qr_code_scanner/presentation/controllers/gallery_image_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/location_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/qr_camera_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/user_id_controller.dart';

import '../../presentation/controllers/generate_qr_controllers/business_controller.dart';
import '../../presentation/controllers/generate_qr_controllers/contact_controller.dart';
import '../../presentation/controllers/generate_qr_controllers/email_controller.dart';
import '../../presentation/controllers/generate_qr_controllers/event_controller.dart';
import '../../presentation/controllers/generate_qr_controllers/instagram_twitter_controller.dart';
import '../../presentation/controllers/generate_qr_controllers/phone_number_controller.dart';
import '../../presentation/controllers/generate_qr_controllers/text_controller.dart';
import '../../presentation/controllers/generate_qr_controllers/website_controller.dart';
import '../../presentation/controllers/generate_qr_controllers/wifi_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserIdController>(UserIdController(), permanent: true);
    Get.put<GalleryImageController>(GalleryImageController(), permanent: true);
    Get.put<QrCameraController>(QrCameraController(), permanent: true);
    Get.put<BusinessController>(BusinessController(), permanent: true);
    Get.put<ContactController>(ContactController(), permanent: true);
    Get.put<EmailController>(EmailController(), permanent: true);
    Get.put<EventController>(EventController(), permanent: true);
    Get.put<InstagramTwitterController>(
      InstagramTwitterController(),
      permanent: true,
    );
    Get.put<PhoneNumberController>(PhoneNumberController(), permanent: true);
    Get.put<TextController>(TextController(), permanent: true);
    Get.put<WebSiteController>(WebSiteController(), permanent: true);
    Get.put<WifiController>(WifiController(), permanent: true);
    Get.put<LocationController>(LocationController(), permanent: true);
  }
}
