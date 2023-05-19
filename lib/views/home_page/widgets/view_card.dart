import 'package:flutter/material.dart';

import '../../../models/note.dart';

class ViewCard extends StatelessWidget {
  const ViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    Note note =
        ModalRoute.of(context)!.settings.arguments as Note;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: const Color(0xA5CFE6FF),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                        fontSize: 20
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      note.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
