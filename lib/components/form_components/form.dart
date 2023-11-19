import 'dart:async';
import 'dart:ffi';

import 'package:chat_app_dart/components/form_components/decorators/data.dart';
import 'package:chat_app_dart/tcp_sockets/message/message_interface.dart';
import 'package:chat_app_dart/tcp_sockets/message/message_reflector.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/components/form_components/input_field.dart';
import 'package:chat_app_dart/components/ripple_button/ripple_button.dart';
import 'package:chat_app_dart/utils/colors.dart';
import 'package:reflectable/reflectable.dart';

class MessageForm<SubmitType extends IMessage> extends StatelessWidget {
  MessageForm({super.key, this.onSubmit});
  MessageReflector messageReflector = const MessageReflector();
  // final List<InputField> formFields;
  Map<String, List<Data>> formFields() {
    Map<String, List<Data>> res = {};
    ClassMirror classMirror =
        (messageReflector.reflectType(SubmitType) as ClassMirror);
    Map<String, DeclarationMirror> declarations = classMirror.declarations;
    for (String declarationMirrorKey in declarations.keys) {
      DeclarationMirror? declarationMirror = declarations[declarationMirrorKey];
      if (declarationMirror is! VariableMirror) {
        continue;
      }
      List<Data> attribute_data_requirements = fieldValidationRequiries(
          declarations[declarationMirrorKey] as VariableMirror);
      if (attribute_data_requirements.isNotEmpty) {
        res[declarationMirrorKey] = attribute_data_requirements;
      }
    }
    print(res.keys);
    return res;
  }

  List<Data> fieldValidationRequiries(VariableMirror mirror) {
    List<Data> res = [];
    for (var data in mirror.metadata) {
      if (data is Data) {
        print(data);
        res.add(data);
      }
    }
    return res;
  }

  Map<String, List<Data>> form_fields = {};

  Map<String, InputField> form_children = {};
  FutureOr<void> Function(SubmitType instance)? onSubmit;
  void _submit() {
    for (InputField inputField in form_children.values) {
      if (!inputField.check()) {
        return;
      }
    }
    if (onSubmit == null) {
      return;
    }
    ClassMirror classMirror =
        messageReflector.reflectType(SubmitType) as ClassMirror;
    print(classMirror.simpleName);
    SubmitType instance = classMirror.newInstance(
        "", form_children.values.map((e) => e.value).toList()) as SubmitType;

    onSubmit!(instance);
  }

  void initFormChildren() {
    for (var key in form_fields.keys) {
      form_children[key] = InputField(
        lable: key,
        validationRequirements: form_fields[key]!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    form_fields = formFields();
    initFormChildren();
    List<Widget> children = [
      ...form_children.values,
      SizedBox(
          width: 335,
          child: RippleButton(
            onTap: () {
              _submit();
            },
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(23)),
                color: PRIMARY,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 19,
                      spreadRadius: 7,
                      offset: const Offset(0, 7),
                      color: SECONDARY)
                ]),
            child: Center(
                child: Text(
              "Sign in",
              style: TextStyle(
                  color: const Color.fromARGB(129, 0, 0, 0),
                  shadows: [
                    Shadow(
                        blurRadius: 25,
                        offset: const Offset(0, 3),
                        color: PRIMARY)
                  ]),
            )),
          ))
    ];
    return SizedBox(
        height: children.length * 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: children,
        ));
  }
}
