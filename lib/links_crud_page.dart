import 'package:flutter/material.dart';
import 'package:kidsy_tv/Firebase/links_store.dart'; // Ensure this import points to your FirestoreService file
import 'package:kidsy_tv/links_display_page.dart';

class CRUD extends StatefulWidget {
  const CRUD({super.key});

  @override
  _CRUDState createState() => _CRUDState();
}

class _CRUDState extends State<CRUD> {
  final TextEditingController _linkController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _fetchLink();
  }

  Future<void> _fetchLink() async {
    String? link = await _firestoreService.getLink();
    if (link != null) {
      setState(() {
        _linkController.text = link;
      });
    }
  }

  void _editDefaultLink() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('E D I T L I N K'),
          content: TextField(
            controller: _linkController,
            decoration: const InputDecoration(labelText: 'Link'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _firestoreService.updateLink(_linkController.text);
                Navigator.of(context).pop();
              },
              child: const Text('U P D A T E',style: TextStyle(color: Colors.black),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('C A N C E L',style: TextStyle(color: Colors.black),)
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 139, 134, 134),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LinksDisplayPage()),
            );
          },
        ),
        title: const Text(
          "L I N K S",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _linkController,
                    decoration: const InputDecoration(
                      labelText: 'L I N K',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _editDefaultLink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
