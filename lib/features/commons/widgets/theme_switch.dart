import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ui/colors/app_colors.dart';
import '../../../ui/icons/app_icons.dart';
import '../../../ui/widgets/switch/animationd_toggle.dart';
import '../providers/theme_provider.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => AnimatedToggle(
        values: const [
          Icon(
            AppIcons.lightModeOutlined,
            color: AppColors.black54,
          ),
          Icon(
            AppIcons.darkModeOutlined,
            color: AppColors.black54,
          )
        ],
        onToggleCallback: (value) async {
          if (ref.watch(themeModeProvider) == ThemeMode.light) {
            await ref.read(themeModeProvider.notifier).setTheme(ThemeMode.dark);
          } else {
            await ref
                .read(themeModeProvider.notifier)
                .setTheme(ThemeMode.light);
          }
        },
        initialPosition: ref.watch(themeModeProvider) == ThemeMode.light,
      );
}
