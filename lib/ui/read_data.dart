import 'package:bike_data_register/ui/calc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bike_data_register/ui/write_data.dart';
import 'package:intl/intl.dart';


class ReadData extends StatefulWidget {
  const ReadData({Key? key}) : super(key: key);

  @override
  _ReadDataState createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {

  bool _isAscending = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Records"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calc()),
                );
              },
              icon: Icon(Icons.calculate),
            ),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:StreamBuilder(
          stream: FirebaseFirestore.instance.collection('records').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // Extract data from snapshot
            List<Map<String, dynamic>> records = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

            // Sort records based on 'time' value
            records.sort((a, b) => b['time'].compareTo(a['time']));

            records.sort((a, b) {
              if (_isAscending) {
                return a['bike'].compareTo(b['bike']);
              } else {
                return b['bike'].compareTo(a['bike']);
              }
            });

            // Generate table rows
            List<TableRow> rows = [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[300]), // Optional: Adding a background color to the title row
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isAscending = !_isAscending; // Toggle sorting order
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              'Bike',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(_isAscending ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Start Dist.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              for (var record in records)
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(record['name']),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(record['bike']),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(record['start']),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(record['time'].toDate()), // Format timestamp using DateFormat
                        ),
                      ),
                    ),
                  ],
                ),
            ];

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(1), // Adjust the width as needed
                    1: FlexColumnWidth(1), // Adjust the width as needed
                    2: FlexColumnWidth(1), // Adjust the width as needed
                    3: FlexColumnWidth(1), // Adjust the width as needed
                  },
                  border: TableBorder.all(),
                  children: rows,
                ),
            );


          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Writedata()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
