import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class TodoProfilePage extends StatefulWidget {
  @override
  _TodoProfilePageState createState() => _TodoProfilePageState();
}

class _TodoProfilePageState extends State<TodoProfilePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String task;

  Box<String> todoBox;

  @override
  void initState() {
    todoBox = Hive.box<String>("friends");
    super.initState();
  }

  // @override
  // void dispose() {
  //   Hive.close(); // close all the box
  //   // Hive.box('transaction').close();  // close only one box
  //   titleController.dispose();

  //   detailController.dispose();
  //   super.dispose();
  // }
  //
  @override
  void dispose() {
    titleController.clear();
    detailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Todo App'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ValueListenableBuilder(
          valueListenable: todoBox.listenable(), //  import flutter_hive in top
          builder: (context, Box<String> todos, _) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  final title = todos.keys.toList()[index];
                  final detail = todos.get(title);
                  final date = DateFormat.yMMMd().format(DateTime.now());
                  return Card(
                    color: Colors.white,
                    child: ExpansionTile(
                      title: Text(
                        title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      tilePadding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text(
                              detail,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              date.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                      // leading: CircleAvatar(
                      //   radius: 70,
                      //   child: Text(
                      //     todo.amount.toString(),
                      //     style: TextStyle(
                      //         fontSize: 18, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      children: [
                        buildButtons(context),
                      ],
                    ),
                  );
                  // return ListTile(
                  //   title: Text(
                  //     todo.title,
                  //     style:
                  //         TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  //   ),
                  //   subtitle: Text(
                  //     todo.detail,
                  //     style:
                  //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //   ),
                  // );
                },
                // separatorBuilder: (_, index) => Divider(),
                itemCount: todos.keys.toList().length);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            titleController.clear();
            detailController.clear();
            _buildShowDialog(context);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future _buildShowDialog(BuildContext context) {
    AlertDialog();

    return showDialog(
        useSafeArea: true,
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          task = value;
                        },
                        controller: titleController,
                        validator: (title) => title != null && title.isEmpty
                            ? 'Enter the title'
                            : null,
                        decoration: InputDecoration(
                          hintText: "Title",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: Colors.green)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: Colors.green)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          task = value;
                        },
                        validator: (title) => title != null && title.isEmpty
                            ? 'Enter the detail'
                            : null,
                        controller: detailController,
                        decoration: InputDecoration(
                          focusColor: Colors.green,
                          hintText: "Detail",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: Colors.green)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: Colors.green)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 12)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 12)),
                              onPressed: () async {
                                setState(() {});
                                final isValid = formKey.currentState.validate();

                                if (isValid) {
                                  final String title = titleController.text;
                                  final String detail = detailController.text;

                                  todoBox.put(title, detail);
                                  Navigator.pop(context);
                                }

                                // final double amount =
                                //     double.tryParse(amountController.text);
                              },
                              child: Text('Add Item')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildButtons(
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
            child: TextButton.icon(
                onPressed: () {
                  _buildShowDialog(context);
                },
                icon: Icon(Icons.edit),
                label: Text('Edit'))),
        Expanded(
            child: TextButton.icon(
                onPressed: () {
                  return _buildShowDialogdelete(context);
                },
                icon: Icon(Icons.delete),
                label: Text('Delete'))),
      ],
    );
  }

  Future _buildShowDialogdelete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: "Title", border: OutlineInputBorder()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 12)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 12)),
                            onPressed: () {
                              final String title = titleController.text;

                              // final double amount =
                              //     double.tryParse(amountController.text);

                              todoBox.delete(title);
                              Navigator.pop(context);
                            },
                            child: Text('Delete')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
