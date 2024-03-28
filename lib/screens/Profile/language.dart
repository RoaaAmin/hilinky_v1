import 'package:flutter/material.dart';
import 'package:hiwetaan/components/context.dart';
import 'package:hiwetaan/screens/Profile/profile.dart';

class language extends StatefulWidget {
   language({super.key});

  @override
  State<language> createState() => _languageState();
}

class _languageState extends State<language> {
  int selectedOption=1;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          title: const Center(
            child: Text(
              "Language",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
           leading: IconButton(
                onPressed: () {
                  context.pop( profiletest());
                },
                icon: const Icon(Icons.arrow_back_ios))
        
        ),
      body:    Column(
   mainAxisAlignment: MainAxisAlignment.start,
 
  children: <Widget>[
    ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      // textAlign: TextAlign.end,
      title: const Text('English (US)'),
    
      
      leading:   Radio(
        value: 1,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
      
    ),
   ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      // textAlign: TextAlign.end,
      title: const Text('English (US)'),
    
      
      leading:   Radio(
        value: 2,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
      
    ),

    ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      // textAlign: TextAlign.end,
      title: const Text('English (US)'),
    
      
      leading:   Radio(
        value: 3,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
      
    ),

    ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      // textAlign: TextAlign.end,
      title: const Text('English (US)'),
    
      
      leading:   Radio(
        value: 4,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
      
    ),

    ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      // textAlign: TextAlign.end,
      title: const Text('English (US)'),
    
      
      leading:   Radio(
        value: 5,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
      
    ),

    ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      // textAlign: TextAlign.end,
      title: const Text('English (US)'),
    
      
      leading:   Radio(
        value: 6,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
      
    ),


    ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      // textAlign: TextAlign.end,
      title: const Text('English (US)'),
    
      
      leading:   Radio(
        value: 7,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
      
    ),

    ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      // textAlign: TextAlign.end,
      title: const Text('English (US)'),
    
      
      leading:   Radio(
        value: 8,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
      
    ),
    
  ],
),
    );
  }
}