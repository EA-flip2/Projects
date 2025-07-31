import 'package:flutter/material.dart';
import 'package:sms_project_1/data/local_storage.dart';
import 'package:sms_project_1/data/msg_data.dart';
import 'package:sms_project_1/objects/message.dart';
import 'package:sms_project_1/tools/store_functions.dart';

class MessageInputBox extends StatefulWidget {
  final String groupID;
  final String draftID;
  // final void Function(String) onSend;

  const MessageInputBox({
    super.key,
    required this.groupID,
    required this.draftID,
    // required this.onSend,
  });

  @override
  State<MessageInputBox> createState() => _MessageInputBoxState();
}

class _MessageInputBoxState extends State<MessageInputBox> {
  final TextEditingController _controller = TextEditingController();

  Future<void> addmsg(String msg) async {
    Message thismessage = Message(
      draftID: widget.draftID,
      groupID: widget.groupID,
      msg: msg,
    );
    MessageStore metaMsg = MessageStore(
      message: thismessage.msg ?? 'No message',
      groupID: thismessage.groupID,
      draftID: thismessage.draftID,
      messageID: thismessage.messageID,
    );
    await StoreFunctions.addMessage(metaMsg);
    messages.add(thismessage);
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expandable TextField
        TextField(
          controller: _controller,
          maxLines: 8, // Expands vertically
          minLines: 1,
          decoration: InputDecoration(
            hintText: "Type your message...",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 10),
        // Save and Send Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text("Save"),
              onPressed: () async {
                await addmsg(_controller.text.trim());
                print(
                  '${widget.draftID} this is the draft and ${widget.groupID} is groupId ',
                );
              },
            ),
            Spacer(),
            ElevatedButton.icon(
              icon: Icon(Icons.send),
              label: Text("Send"),
              onPressed: () {
                print("message sent");
              },
            ),
          ],
        ),
      ],
    );
  }
}
