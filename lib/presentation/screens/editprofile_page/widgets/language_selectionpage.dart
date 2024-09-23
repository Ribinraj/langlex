import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageSelectionSheet extends StatefulWidget {
  @override
  _LanguageSelectionSheetState createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  // List of available languages
  final List<Map<String, String>> languages = [
    {'English': 'en'},
    {'हिन्दी': 'hi'},
    {'ಕನ್ನಡ': 'ka'},
    {'தமிழ்': 'ta'},
    {'मराठी': 'mr'}
  ];

  // Set to store the selected languages, initialized with 'en', 'hi', and 'ka'
  Set<String> selectedLanguages = {'en', 'hi', 'ka'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Languages'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                String languageName = languages[index].keys.first;
                String languageCode = languages[index].values.first;

                bool isSelected = selectedLanguages.contains(languageCode);

                return ListTile(
                  title: Text(languageName),
                  trailing: isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        // Remove language if already selected
                        selectedLanguages.remove(languageCode);
                      } else if (selectedLanguages.length < 3) {
                        // Add language if less than 3 selected
                        selectedLanguages.add(languageCode);
                      } else {
                        // Show message if more than 3 languages are selected
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('You can select up to 3 languages only'),
                        ));
                      }
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Return selected languages to the parent widget
                Navigator.pop(context, selectedLanguages.toList());
              },
              child: Text('Confirm Selection'),
            ),
          ),
        ],
      ),
    );
  }
}