import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';
import 'package:zoom_clone/utils/colors.dart';

class HistoryMeetingScreen extends StatefulWidget {
  const HistoryMeetingScreen({super.key});

  @override
  State<HistoryMeetingScreen> createState() => _HistoryMeetingScreenState();
}

class _HistoryMeetingScreenState extends State<HistoryMeetingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirestoreMethods().meetingsHistory,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: buttonColor),
              );
            } else {
              if ((snapshot.data!).docs.isEmpty) {
                return const Center(
                  child: Text(
                    'No meeting history available',
                    style: TextStyle(color: Colors.white54),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: (snapshot.data!).docs.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title: Text(
                          'Room Name: ${(snapshot.data! as dynamic).docs[index]['meetingName']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                            'Joined on ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}',
                            style: const TextStyle(color: Colors.white54)),
                      );
                    }));
              }
            }
          })),
    );
  }
}
