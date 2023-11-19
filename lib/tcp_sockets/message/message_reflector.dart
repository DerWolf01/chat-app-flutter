import 'dart:isolate';

import 'package:reflectable/reflectable.dart';

class MessageReflector extends Reflectable {
  const MessageReflector()
      : super(invokingCapability, declarationsCapability, metadataCapability,
            typingCapability, metadataCapability, instanceInvokeCapability);
}
