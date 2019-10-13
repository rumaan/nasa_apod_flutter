import 'package:permission_handler/permission_handler.dart';

permissionCheck() async {
  if (await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage) !=
      PermissionStatus.granted) {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }
}
