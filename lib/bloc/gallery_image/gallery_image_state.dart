part of 'gallery_image_bloc.dart';

class GalleryImageState extends Equatable {
  final File? file;
  final String qrLink;
  final String scannedCode;
  final File? selectedFile;

  GalleryImageState({
    this.file,
    this.qrLink = "",
    this.selectedFile,
    this.scannedCode = "",
  });

  @override
  List<Object?> get props => [file, qrLink, selectedFile, scannedCode];

  GalleryImageState copyWith({
    File? file,
    String? qrLink,
    File? selectedFile,
    String? scannedCode,
  }) => GalleryImageState(
    file: file ?? this.file,
    qrLink: qrLink ?? this.qrLink,
    scannedCode: scannedCode ?? this.scannedCode,
    selectedFile: selectedFile ?? this.selectedFile,
  );
}
