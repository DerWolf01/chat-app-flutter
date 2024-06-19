import 'package:chat_app_dart/active_contacts/active_contacts_service.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:flutter/material.dart';

class OnlineDotWidget extends StatefulWidget {
  const OnlineDotWidget({required this.contact, super.key});

  final int contact;

  @override
  State<StatefulWidget> createState() => OnlineDotWidgetState();
}

class OnlineDotWidgetState extends State<OnlineDotWidget> {
  ActiveContactsService get _activeContactsService =>
      getIt<ActiveContactsService>();
  bool online = false;

  Future<void> listener(int? id) async {
    print("got id --> $id, contact is ${widget.contact}");
    if (id == widget.contact) {
      setState(() => online = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _activeContactsService.addListener(listener);
    if (_activeContactsService.active.containsKey(widget.contact)) {
      setState(() {
        online = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _activeContactsService.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 9,
      width: 9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: online ? Colors.green : Colors.red),
      duration: Duration(milliseconds: 255),
    );
  }
}
