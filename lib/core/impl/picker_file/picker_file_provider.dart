import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'picker_file_impl.dart';

/// Picker File provider
final pickerFileProvider = Provider<FilePicker>((ref) => FilePicker.platform);

/// Picker file Impl provider
final pickerFileImplProvider = Provider<PickerFileImpl>(
  (ref) {
    final filePicker = ref.watch(pickerFileProvider);
    return PickerFileImpl(filePicker: filePicker);
  },
);
