import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

abstract class BaseRepository {
  //'count' to handle for UnauthorizedRequest with multiple api case
  // Avoid show Toast Unautherized many times.

  FormData wrapFormData<T>(T source) {
    return FormData.fromMap({
      "source": MultipartFile.fromString(jsonEncode(source),
          contentType: MediaType.parse('application/json'))
    });
  }

  FormData wrapMapFormData(Map<String, dynamic> body) {
    final Map<String, dynamic> request = body.map((key, value) => MapEntry(
        key,
        value is List<File>
            ? value.map((e) => MultipartFile.fromFileSync(e.path)).toList()
            : value is File
                ? MultipartFile.fromFile(value.path)
                : MultipartFile.fromString(value,
                    contentType: MediaType.parse('application/json'))));
    return FormData.fromMap(request);
  }

  Stream<Uint8List> wrapBinary(File file) {
    final binary = file.openRead().cast<Uint8List>();
    return binary;
  }

  // ApiResult<T> handleErrorApi<T>(dynamic e,
  //     {String tag = "", forceLogout = true}) {
  //   NetworkExceptions exceptions = NetworkExceptions.getDioException(e);
  //   if (forceLogout && exceptions is UnauthorizedRequest) {
  //     return const ApiResult.failure(error: NetworkExceptions.notFound(""));
  //   }
  //   print('check apiresult ${ApiResult.failure(error: exceptions)}');
  //   return ApiResult.failure(error: exceptions);
  // }

  ApiResult<T> handleErrorApi<T>(dynamic e,
      {String tag = '', forceLogout = true}) {
    print('check e dio ${e}');
    final NetworkExceptions exceptions = NetworkExceptions.getDioException(e);
    if (forceLogout && exceptions is UnauthorizedRequest) {
      return const ApiResult.failure(error: NetworkExceptions.notFound(''));
    }

    return ApiResult.failure(error: exceptions);
  }

  // Future<FormData> createFormDataFromImageList(
  //     List<ImageData> imageDataList) async {
  //   FormData formData = FormData();

  //   try {
  //     for (var i = 0; i < imageDataList.length; i++) {
  //       //  imageDataList[i];

  //       if (imageDataList[i].uint8list != null) {
  //         // Tạo một tệp tin tạm thời từ uint8list
  //         // final tempDir = await getTemporaryDirectory();
  //         // File file = await File('${tempDir.path}/${imageDataList[i].name}.jpg')
  //         //     .create();
  //         // file.writeAsBytesSync(imageDataList[i].uint8list!);
  //         // var compressedImage = await FlutterImageCompress.compressWithFile(
  //         //   file.path,
  //         //   format: CompressFormat.jpeg,
  //         //   quality: Platform.isIOS ? 30 : 30,
  //         // );
  //         // file = File(file.path);
  //         // await file.writeAsBytes(compressedImage!.toList());

  //         // Thêm tệp tin vào FormData dưới dạng MultipartFile
  //         formData.files.add(
  //           MapEntry(
  //             'images',
  //             await MultipartFile.fromBytes(
  //               imageDataList[i].uint8list!,
  //               // File(file.path).readAsBytesSync(),
  //               // file.path,
  //               filename: imageDataList[i].name,
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     logger.d(e);
  //   }
  //   print('check formdata ${formData.length}');

  //   return formData;
  // }
}
