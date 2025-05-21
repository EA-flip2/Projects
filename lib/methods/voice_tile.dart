import 'package:a_voice/methods/playBack_methods.dart';
import 'package:a_voice/methods/pop_up_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class voice_tile extends StatefulWidget {
  final int index;
  final recording_name;
  final recording_date;
  final recording_length;
  final recording_path;

  const voice_tile({
    super.key,
    required this.index,
    required this.recording_name,
    required this.recording_date,
    required this.recording_length,
    required this.recording_path,
  });

  @override
  State<voice_tile> createState() => _voice_tileState();
}

class _voice_tileState extends State<voice_tile> {
  bool isPlaying = false; // Placeholder for recording playing state

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 25, right: 15.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // Add your delete functionality here
              },
              icon: Icons.delete,
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),

            SlidableAction(
              onPressed: (context) {
                // add to favourites
              },
              icon: Icons.edit,
              backgroundColor: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ],
        ),

        child: GestureDetector(
          onDoubleTap: () {
            // move to player Page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 10,
                  child: Text(widget.index.toString()),
                ), // index number

                SizedBox(
                  child:
                      isPlaying
                          ? IconButton(
                            icon: Icon(Icons.stop),
                            onPressed: () {
                              // Pause the recording
                              stopRecording();
                              setState(() {
                                isPlaying = false;
                              });
                            },
                          )
                          : IconButton(
                            icon: Icon(Icons.play_arrow),
                            onPressed: () {
                              // Play the recording
                              playRecording(widget.recording_path);
                              setState(() {
                                isPlaying = true;
                              });
                            },
                          ),
                ), // play button

                Flexible(
                  flex: 2,
                  child: Text(
                    widget.recording_name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(decoration: TextDecoration.none),
                  ),
                ), // Name of the recording

                Flexible(
                  flex: 2,
                  child: Text(
                    DateFormat.yMd().format(
                      DateTime.parse(widget.recording_date),
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(decoration: TextDecoration.none),
                  ),
                ),

                Flexible(
                  flex: 1,
                  child: Text(
                    widget.recording_length,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(decoration: TextDecoration.none),
                  ),
                ), // duration of the recording

                SizedBox(
                  width: 10,
                  child: GestureDetector(
                    child: Icon(Icons.more_vert),
                    onTap:
                        () => showPopover(
                          context: context,
                          bodyBuilder:
                              (context) => record_details(
                                record_name: widget.recording_name,
                                recording_date: widget.recording_date,
                                recording_length: widget.recording_length,
                                recording_path: widget.recording_path,
                              ),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 25, right: 15.0),

      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              Checkbox(
                value: taskComplete,
                onChanged: onChange,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style: TextStyle(
                  decoration:
                      taskComplete
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
*/
