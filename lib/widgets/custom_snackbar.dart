import 'package:gymnotes/all_imports.dart';

Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
    showCustomSnackBar(
  BuildContext context,
  String text,
) async {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          ScaffoldMessenger.of(context)
              .hideCurrentSnackBar(reason: SnackBarClosedReason.action);
        },
      ),
    ),
  );
}
