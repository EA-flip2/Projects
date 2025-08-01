import 'package:flutter/material.dart';

class Contact {
  const Contact({required this.name, required this.number});
  final String name;
  final String number;
}

void addContact(
  BuildContext context,
  Function(String name, String number) passContact,
) {
  final contactName = TextEditingController();
  final contactNumber = TextEditingController();

  showModalBottomSheet(
    isScrollControlled: true, // prevents keyboard overlay
    useSafeArea: true, // make sure it's in safe area
    context: context,

    // isScrollControlled: true, // important for larger content
    builder: (ctx) {
      final sheight = MediaQuery.of(ctx).size.height;
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        height: sheight,
        child: Column(
          mainAxisSize: MainAxisSize.min, // fit to content
          children: [
            SizedBox(height: sheight * 0.35 * 0.1),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 15,
                    controller: contactName,
                    decoration: InputDecoration(
                      label: Text("Name"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    maxLength: 15,
                    controller: contactNumber,
                    decoration: InputDecoration(
                      label: Text("Number"),
                      hintText: 'format: 020XXXXXX5',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: sheight * 0.35 * 0.1),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    if (contactNumber.text.trim().isEmpty) {
                      Navigator.of(ctx).pop();
                    } else {
                      // Save logic here
                      passContact(
                        contactName.text.trim().isEmpty
                            ? "Unknown"
                            : contactName.text.trim(),
                        contactNumber.text.trim(),
                      );
                    }
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Done"),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
            SizedBox(height: sheight * 0.35 * 0.2),
          ],
        ),
      );
    },
  );
}
