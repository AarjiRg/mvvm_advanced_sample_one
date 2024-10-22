import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:mvvm_advanced_sample_one/ui/tools/tools/screen_size.dart';
import 'package:mvvm_advanced_sample_one/ui/tools/tools/smart_dialog_config.dart';
import 'package:mvvm_advanced_sample_one/ui/widgets/widgets/setup_dependencies.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:statusbarz/statusbarz.dart';

import 'app/app.router.dart';
import 'constants/app_colors.dart';
import 'constants/app_strings.dart';
import 'constants/fonts.gen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (!kIsWeb) {
    if (Platform.isAndroid) {
      DeviceOrientation.portraitUp;
      // ByteData data = await PlatformAssetBundle().load(
      //   Assets.ca.letsEncryptR3,
      // );
      // SecurityContext.defaultContext.setTrustedCertificatesBytes(
      //   data.buffer.asUint8List(),
      // );
    }
  }
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) {
        return StatusbarzCapturer(
          child: MaterialApp(
            title: AppStrings.appName,
            theme: ThemeData(
              primarySwatch: generateMaterialColor(Palette.primary),
              fontFamily: FontFamily.barlow,
              scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
            ),
            builder: FlutterSmartDialog.init(
              builder: (context, child) {
                ScreenSize.init(context);

                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: child!,
                );
              },
              toastBuilder: toastBuilder,
              loadingBuilder: loadingBuilder,
            ),
            navigatorKey: StackedService.navigatorKey,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorObservers: [
              StackedService.routeObserver,
              Statusbarz.instance.observer,
              FlutterSmartDialog.observer
            ],
          ),
        );
      },
    );
  }
}
