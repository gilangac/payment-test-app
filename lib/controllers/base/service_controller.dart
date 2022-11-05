// ignore_for_file: avoid_print, unused_field
import 'package:payment_test_app/helpers/snackbar_helper.dart';
import 'package:payment_test_app/routes/pages.dart';
import 'package:payment_test_app/serivces/service_exception.dart';
import 'package:get/get.dart';

class ServiceController {
  void handleError(error) {
    if (error is BadRequestException) {
      Get.back();

      var message = error.message;
      var url = error.url;

      if (url == '/charge') {
        if (Get.isDialogOpen!) Get.back();
        SnackBarHelper.showError(
            description: _errorMessages[url]?['description'] ?? message);
      }
    } else if (error is ApiNotRespondingException) {
      var message = error.message;
      if (Get.isDialogOpen!) Get.back();
      // Get.snackbar("Gagal", message);
    } else if (error is UnauthorizedException) {
      var message = error.message;
      if (Get.isDialogOpen!) Get.back();
      // Get.snackbar("Gagal", message);
      Get.offAndToNamed(AppPages.HOME);
    } else if (error is FetchDataException) {
      var message = error.message;
      if (Get.isDialogOpen!) Get.back();
      // Get.snackbar("Gagal", message);
    }
  }

  static final _errorMessages = {
    '/login': {
      'title': 'Login Gagal',
      'description':
          'Waduh sepertinya email atau password yang anda masukkan salah. Silahkan masukkan email dan password lagi dengan benar.',
    },
    '/register': {
      'title': 'Registrasi Gagal',
      'description':
          'Waduh sepertinya ada masalah saat melakukan registrasi. Pastikan data yang anda inputkan sudah benar dan silahkan coba lagi.',
    },
    '/password/reset': {
      'title': 'Permintaan Gagal',
      'description':
          'Waduh sepertinya ada masalah saat melakukan permintaan. Pastikan data yang anda inputkan sudah benar dan silahkan coba lagi.',
    },
    '/password/change': {
      'title': 'Update Gagal',
      'description':
          'Waduh sepertinya kata sandi lama yang anda masukkan salah.'
    }
  };
}
