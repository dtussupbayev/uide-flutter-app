import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:uide/ui/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.bedroom1).existsSync(), true);
    expect(File(Images.budgetRoom1).existsSync(), true);
    expect(File(Images.googleLogo).existsSync(), true);
    expect(File(Images.kairatNurtas).existsSync(), true);
    expect(File(Images.logo).existsSync(), true);
    expect(File(Images.mainRoom).existsSync(), true);
    expect(File(Images.richRoom).existsSync(), true);
    expect(File(Images.singleRoom).existsSync(), true);
    expect(File(Images.userAvatar).existsSync(), true);
    expect(File(Images.userAvatar2).existsSync(), true);
    expect(File(Images.userAvatar3).existsSync(), true);
  });
}
