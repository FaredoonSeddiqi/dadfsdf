import 'package:flutter/material.dart';
import 'package:postmethod/datamodel/model.dart';
import 'package:http/http.dart' as http;

class uipage extends StatefulWidget {
  const uipage({super.key});

  @override
  State<uipage> createState() => _uipageState();
}

Future<DataModel?> subdata(String name, String job) async {
  var resp = await http.post(Uri.https('reqres.in', 'api/user'),
      body: {"name": name, "job": job});
  var dataa = resp.body;
  print(dataa);
  if (resp.statusCode == 201) {
    String respstring = resp.body;

    dataModelFromJson(respstring);
  } else {
    return null;
  }
  return null;
}

class _uipageState extends State<uipage> {
  late DataModel _dataModel;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController jobcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post method',
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter your name ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter your job name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String name = namecontroller.text;
                    String job = jobcontroller.text;

                    DataModel? data = await subdata(name, job);
                    setState(() {
                      _dataModel = data!;
                    });
                  },
                  child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
