part of 'gallery_image_bloc.dart';

abstract class GalleryImageEvent extends Equatable {
  GalleryImageEvent();
}

class SetImageChange extends GalleryImageEvent {
  final File selectedFile;

  SetImageChange({required this.selectedFile});

  @override
  List<Object?> get props => [selectedFile];
}

class SetQrLink extends GalleryImageEvent {
  final String scannedCode;

  SetQrLink({required this.scannedCode});

  @override
  List<Object?> get props => [scannedCode];
}

class SetImageQrLinkNull extends GalleryImageEvent {
  @override
  List<Object?> get props => [];
}

class SetImageNull extends GalleryImageEvent {
  @override
  List<Object?> get props => [];
}
