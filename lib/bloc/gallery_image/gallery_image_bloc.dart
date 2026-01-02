import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gallery_image_event.dart';

part 'gallery_image_state.dart';

class GalleryImageBloc extends Bloc<GalleryImageEvent, GalleryImageState> {
  GalleryImageBloc() : super(GalleryImageState()) {
    on<SetImageChange>(_setImageChange);
    on<SetQrLink>(_setQrLink);
    on<SetImageQrLinkNull>(_setImageQrLinkNull);
    on<SetImageNull>(_setImageNull);
  }

  void _setImageChange(SetImageChange event, Emitter<GalleryImageState> emit) {
    emit(state.copyWith(file: event.selectedFile, qrLink: ""));
  }

  void _setQrLink(SetQrLink event, Emitter<GalleryImageState> emit) {
    emit(state.copyWith(qrLink: event.scannedCode));
  }

  void _setImageQrLinkNull(
    SetImageQrLinkNull event,
    Emitter<GalleryImageState> emit,
  ) {
    emit(state.copyWith(file: null, qrLink: ""));
  }

  void _setImageNull(SetImageNull event, Emitter<GalleryImageState> emit) {
    emit(state.copyWith(file: null));
  }
}
