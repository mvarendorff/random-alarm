import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogBase extends StatelessWidget {
  final VoidCallback? onDone;
  final void Function(String)? onSearchChange;
  final VoidCallback? onSearchClear;
  final Widget child;

  DialogBase(
      {Key? key,
      this.onDone,
      required this.child,
      this.onSearchChange,
      this.onSearchClear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: onSearchChange,
                    controller: controller,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => controller.clear(),
                )
              ],
            ),
            Expanded(child: this.child),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: Get.back,
                ),
                TextButton(
                  child: Text('Done'),
                  onPressed: () {
                    onDone?.call();
                    Get.back();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
