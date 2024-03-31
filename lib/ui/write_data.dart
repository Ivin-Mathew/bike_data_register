import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bike_data_register/ui/read_data.dart';

class Writedata extends StatefulWidget {
  const Writedata({Key? key}) : super(key: key);

  @override
  State<Writedata> createState() => _WritedataState();
}

class _WritedataState extends State<Writedata> {
  TextEditingController _name= TextEditingController();
  TextEditingController _start= TextEditingController();
  String? _bike; // Move the declaration here
  DateTime _startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReadData()),
            );
          },
        ),
        title: Text('Add Record'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: _name,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: "Name",
                    prefixIcon : Icon(Icons.person,color: Colors.black)
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Radio<String>(
                    value: "FZ",
                    groupValue: _bike,
                    onChanged: (value) {
                      setState(() {
                        _bike = value;
                      });
                    },
                  ),
                  Text('FZ'),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Glamour',
                    groupValue: _bike,
                    onChanged: (value) {
                      setState(() {
                        _bike = value;
                      });
                    },
                  ),
                  Text('Glamour'),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _start,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: "Start Distance",
                    prefixIcon : Icon(Icons.play_circle_outline_outlined,color: Colors.black)
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              // Displaying the current date and time
              Text('Current Time: $_startTime'),


              SizedBox(
                height: 40.0,
              ),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Color.fromARGB(255, 49, 90, 255),
                  elevation:0.0 ,
                  padding: EdgeInsets.symmetric(vertical:20.0),
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12.0)),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('records')
                        .add({
                      "name": _name.text,
                      "bike":_bike,
                      "start":_start.text,
                      "time": Timestamp.fromDate(_startTime) // Convert DateTime to Timestamp
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReadData()),);
                  },
                  child: Text("Submit", style:TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18.0,
                  )),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
