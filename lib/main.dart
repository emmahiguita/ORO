import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/binding/initialbinding.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/localization/changelocale.dart';
import 'package:oro/core/localization/translation.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/core/theme/app_theme.dart';
import 'package:oro/routes.dart';
import 'package:oro/view/widgets/main/draggableverificationprompt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Appcolor.ink,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  await InitialServices();
  if (kReleaseMode && !AppLink.isProductionUrlSafe) {
    runApp(const ConfigurationErrorApp());
    return;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Get.put(Localecontroller());
    return GetMaterialApp(
      title: 'ORO',
      debugShowCheckedModeBanner: false,
      locale: locale.languge,
      fallbackLocale: const Locale('es'),
      initialBinding: InitialBindings(),
      translations: Translation(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 320),
      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            GetBuilder<Localecontroller>(builder: (services) {
              return services.geIsVerified()
                  ? const DraggableVerificationPrompt()
                  : const SizedBox.shrink();
            }),
          ],
        );
      },
      getPages: route,
    );
  }
}

class ConfigurationErrorApp extends StatelessWidget {
  const ConfigurationErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: const Padding(
                padding: EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.security_rounded, size: 52),
                    SizedBox(height: 18),
                    Text(
                      'Configuración de producción incompleta',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'La versión release exige API_BASE_URL con HTTPS y un host real. '
                      'Compila nuevamente con --dart-define=API_BASE_URL=https://tu-dominio/api.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
