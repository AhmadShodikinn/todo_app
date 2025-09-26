import 'package:flutter/material.dart';

// widgets ini dipisah, untuk menampilkan fitur perubahan nama list

class RenameListDialog extends StatelessWidget {
  final String initialValue; // value awal aplikasi, data disimpan secara statis, bukan dari database
  final ValueChanged<String> onRename;

  const RenameListDialog({
    super.key,
    required this.initialValue,
    required this.onRename,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialValue);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'List name',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final newName = controller.text.trim();
                    if (newName.isNotEmpty) {
                      onRename(newName);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
