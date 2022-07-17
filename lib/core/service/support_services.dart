import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

const _url = 'tel:+967 775 152 516';

class SupportServices {
  openwhatsapp() async {
    var whatsapp = "+967775152516";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        Get.snackbar('error', 'whatsapp no installed');
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        Get.snackbar('error', 'whatsapp no installed');
      }
    }
  }

  makeCall() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
