#!/bin/bash
set -e
flutter pub get
sh scripts/import_files_coverage.sh template
flutter test --coverage
lcov --remove coverage/lcov.info \
'lib/main_dev.dart' \
'lib/main_preprod.dart' \
'lib/main_prod.dart' \
'lib/app.dart' \
'lib/ui/*.dart' \
'lib/core/utils/utils_ui.dart' \
'lib/core/constants/*.dart' \
'lib/core/enums/*.dart' \
'lib/core/locales/*' \
'lib/core/router/*' \
'lib/*/*.g.dart' \
'lib/*/*.freezed.dart' \
'lib/features/*/presentation/pages/*.dart' \
'lib/features/*/presentation/widgets/*.dart' \
'lib/features/*/presentation/providers/*.dart' \
'lib/features/commons/*.dart' \
'lib/*/*_provider.dart' \
-o coverage/lcov.info
if [ -n "$1" ]
then
    if [ "$1" = true ]
    then
        genhtml coverage/lcov.info -o coverage
        open coverage/index.html
    fi
fi