import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/locales/generated/l10n.dart';
import '../../../core/providers/locale_provider.dart';

class LangPicker extends ConsumerWidget {
  const LangPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          value: ref.watch(localeProvider),
          items: S.delegate.supportedLocales
              .map(
                (locale) => DropdownMenuItem<Locale>(
                  value: locale,
                  onTap: () async =>
                      ref.read(localeProvider.notifier).setLocale(locale),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/flags/flag_${locale.languageCode}.png',
                      ),
                      radius: 15,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (_) {},
        ),
      );
}
