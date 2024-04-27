import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chocobi/data/money.dart';
import 'package:chocobi/screens/home.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/testCard.dart';
import 'package:intl/intl.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {

  List<Map<String, dynamic>> history = [
    {
      "category": "income",
      "_selected": true
    },
    {
      "category": "expense",
      "_selected": true
    }
  ];

  String formatNumberWithThousandSeparator(num number) {
    final formatter = NumberFormat('#,##0', 'id');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 80, 156), 
        title: Text(
          "Transaction History", 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  FilterChip(
                    selectedColor: Color.fromARGB(255, 17, 80, 156),
                    checkmarkColor: Colors.white,
                    selected: history[0]["_selected"],
                    label: Text(
                      "Income",
                      style: TextStyle(
                        color: history[0]["_selected"] ? Colors.white : Colors.black),
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        history[0]["_selected"] = !history[0]["_selected"];
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  FilterChip(
                    selectedColor: Color.fromARGB(255, 17, 80, 156),
                    checkmarkColor: Colors.white,
                    selected: history[1]["_selected"],
                    label: Text(
                      "Expense",
                      style: TextStyle(
                        color: history[1]["_selected"] ? Colors.white : Colors.black),
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        history[1]["_selected"] = !history[1]["_selected"];
                      });
                    },
                  )
                ],
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: all.length,
                  itemBuilder: (context, position) {
                    if ((history[0]["_selected"] && all[position]["category"] == "income") ||
                        (history[1]["_selected"] && all[position]["category"] == "expense")) {
                      IconData iconData = all[position]["category"] == "income" ? Icons.arrow_drop_up : Icons.arrow_drop_down;
                      Color iconColor = all[position]["category"] == "income" ? Colors.green : Colors.red;

                      return SizedBox(
                        height: MediaQuery.of(context).size.height/10,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${all[position]['date']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text("${all[position]['description']}", style: TextStyle(color: iconColor, fontSize: 18))
                                  ],
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 130,
                                        child: Text("Rp ${formatNumberWithThousandSeparator(all[position]['price'])}", style: TextStyle(color: iconColor, fontSize: 20), textAlign: TextAlign.right)
                                      ),
                                      Icon(iconData, color: iconColor, size: 40)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      );
                    } 
                    else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.home, size: 30), onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    ModalRoute.withName("/Profile"));
                }),
                Text('Home',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.swap_horiz, color: Color.fromARGB(255, 17, 80, 156), size: 30), onPressed: () {} ),
                Text('Transaction',style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 17, 80, 156), fontWeight: FontWeight.bold)), 
              ],
            ),
            FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 21, 96, 189),
              child: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                showDialog(context: context, builder: (context){
                  return SizedBox(
                    height: 400,
                    child: AlertDialog(
                      title: Text("Add Transaction ?"),
                      actions: [
                        TextButton(onPressed: (){
                          showDialog(context: context, builder: (context){
                            return SizedBox(
                              height: 400,
                              child: AlertDialog(
                                title: Text("Insert Transaction"),
                                actions: [
                                  TextButton(onPressed: (){}, child: Text("ADD", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                                  TextButton(onPressed: (){}, child: Text("CANCEL", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                                ],
                                content: SizedBox(
                                  height: 400,
                                  width: 350,
                                  child: Column(children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Judul",
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Jumlah",
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),),
                                    )],),
                                ),
                              ),
                            );
                          });
                        }, child: Text("ADD",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                        TextButton(onPressed: (){}, child: Text("CANCEL",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                      ],
                    ),
                  );
                });
              }, 
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.account_balance_wallet, size: 30), onPressed: () {
                  showDialog(context: context, builder: (context){return const TestCard();});
                }),
                Text('Budget',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.person, size: 30), onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                    ModalRoute.withName("/Transaction"));
                }),
                Text('Profile',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
          ],
        ),
      ),
    );
  }
}
