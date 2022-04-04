import 'package:gymnotes/all_imports.dart';

ThemeData themeLight = FlexThemeData.light(
  scheme: FlexScheme.outerSpace,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 20,
  appBarOpacity: 0.95,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  tones: FlexTones.vividSurfaces(Brightness.light),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: GoogleFonts.questrial().fontFamily,
);

ThemeData themeDark = FlexThemeData.dark(
  scheme: FlexScheme.outerSpace,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 15,
  appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.90,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 30,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  tones: FlexTones.vividSurfaces(Brightness.dark),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: GoogleFonts.questrial().fontFamily,
);
