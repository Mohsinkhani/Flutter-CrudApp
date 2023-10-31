import 'package:flutter/material.dart';
import 'package:testcrud/createData.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String stdName, stdID, programID;
  late double stdGPA;
  getStudentName(name) {
    this.stdName = name;
  }

  getStudentID(id) {
    this.stdID = id;
  }

  getStudyProgramID(pid) {
    this.programID = pid;
  }

  getStudentCGPA(result) {
    this.stdGPA = double.parse(result);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRUD App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "name",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, style: BorderStyle.solid)),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "email",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, style: BorderStyle.solid)),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Cnic",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, style: BorderStyle.solid)),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Contact",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, style: BorderStyle.solid)),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        backgroundColor: Colors.orange,
                        elevation: 8.0,
                      ),
                      onPressed: () => const createData(),
                      child: const Text(
                        'Create',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 8.0,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const createData()));
                      },
                      child: const Text('Read',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        backgroundColor: Colors.orange,
                        elevation: 8.0,
                      ),
                      onPressed: () => const createData(),
                      child: const Text('Update',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 8.0,
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => const createData(),
                      child: const Text('Delete',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1.0, height: 25.0, color: Colors.green),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Book Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Student ID',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Program ID',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'CGPA',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  textFieldInputDecoration(String s, Icon icon) {}
}
