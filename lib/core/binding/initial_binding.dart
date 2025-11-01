import 'package:get/get.dart';
import 'package:qr_code_scanner/presentation/controllers/gallery_image_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/qr_camera_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/user_id_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserIdController>(UserIdController(), permanent: true);
    Get.put<GalleryImageController>(GalleryImageController(), permanent: true);
    Get.put<QrCameraController>(QrCameraController(), permanent: true);
  }
}
