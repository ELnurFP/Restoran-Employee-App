import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/language/localization.dart';

class CustomAgeRangeDialog extends StatefulWidget {
  const CustomAgeRangeDialog({super.key, this.onSave});

  final Function(String)? onSave;

  @override
  State<CustomAgeRangeDialog> createState() => _CustomAgeRangeDialogState();
}

class _CustomAgeRangeDialogState extends State<CustomAgeRangeDialog> {
  final _endController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _startController = TextEditingController();

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(t.translate("addCustomAgeRange")),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _startController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: t.translate("startAge"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return t.translate("enterStartAge");
                } else if (int.tryParse(value) == null ||
                    int.parse(value) < 15 ||
                    int.parse(value) > 70) {
                  //TODO: yaş aralığın dəyiş lazımsa
                  return t.translate("enterValidAge");
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _endController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: t.translate("endAge"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return t.translate("enterEndAge");
                } else if (int.tryParse(value) == null ||
                    int.parse(value) < 15 ||
                    int.parse(value) > 70) {
                  //TODO: yaş aralığın dəyiş lazımsa
                  return t.translate("enterValidAge");
                } else if (int.parse(value) <=
                    int.parse(_startController.text)) {
                  return t.translate("endAgeGreater");
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(t.translate("cancel")),
          onPressed: () {
            widget.onSave?.call("18-25");
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text(t.translate("save")),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final start = _startController.text.trim();
              final end = _endController.text.trim();
              final newAgeRange = '$start-$end';
              String customAges = "";
              if (locator.get<GetStorage>().hasData("customAgeRanges")) {
                customAges = GetStorage().read("customAgeRanges");
              }
              if (customAges.contains(newAgeRange)) {
                widget.onSave?.call(newAgeRange);
                Navigator.of(context).pop();
                return;
              }

              if (customAges.isNotEmpty) {
                customAges += ",$newAgeRange";
              } else {
                customAges = newAgeRange;
              }
              locator.get<GetStorage>().write("customAgeRanges", customAges);
              widget.onSave?.call(newAgeRange);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
