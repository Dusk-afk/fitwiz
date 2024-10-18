import 'package:fitwiz/features/custom_scaffold/data/models/custom_app_bar_action.dart';
import 'package:fitwiz/features/custom_scaffold/presentation/widgets/custom_scaffold.dart';

/// Acts as a parameter for configuring app bar in [CustomScaffold].
class CustomAppBarParams {
  final String? title;
  final String? previousTitle;
  final List<CustomAppBarAction>? actions;

  const CustomAppBarParams({
    this.title,
    this.previousTitle,
    this.actions,
  });
}
