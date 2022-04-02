import 'package:gymnotes/all_imports.dart';

ThemeData themeLight = FlexThemeData.light(
  scheme: FlexScheme.outerSpace,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 20,
  appBarOpacity: 0.95,
  appBarElevation: 0.5,
  tooltipsMatchBackground: true,
  useSubThemes: true,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
    unselectedToggleIsColored: true,
    popupMenuOpacity: 0.95,
    bottomNavigationBarOpacity: 0.95,
    navigationBarOpacity: 0.95,
    navigationRailOpacity: 0.95,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  useMaterial3ErrorColors: true,
  tones: FlexTones.vividSurfaces(Brightness.light),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  fontFamily: GoogleFonts.questrial().fontFamily,
);

ThemeData themeDark = FlexThemeData.dark(
  scheme: FlexScheme.outerSpace,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 20,
  appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.95,
  appBarElevation: 0.5,
  tooltipsMatchBackground: true,
  useSubThemes: true,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 30,
    unselectedToggleIsColored: true,
    popupMenuOpacity: 0.95,
    bottomNavigationBarOpacity: 0.95,
    navigationBarOpacity: 0.95,
    navigationRailOpacity: 0.95,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  useMaterial3ErrorColors: true,
  tones: FlexTones.vividSurfaces(Brightness.dark),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  fontFamily: GoogleFonts.questrial().fontFamily,
);
