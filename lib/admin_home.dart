import 'package:flutter/material.dart';

class Admin_home extends StatelessWidget {
  Widget _buildSingleContainer({
    required IconData icon,
    required int count,
    required String name,
    required BuildContext context,
  }) {
    // ignore: dead_code, dead_code
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(name)
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              count.toString(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: 3,
                tabs: [
                  Text(
                    "Dashboard",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Manage",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              backgroundColor: Colors.white,
              title: Text(
                "Admin Home",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Container(
                child: TabBarView(
              children: [
                Container(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      _buildSingleContainer(
                        context: context,
                        count: 1,
                        icon: Icons.person,
                        name: "User",
                      ),
                      _buildSingleContainer(
                        context: context,
                        count: 12,
                        icon: Icons.category,
                        name: "Categories",
                      ),
                      _buildSingleContainer(
                        context: context,
                        count: 30,
                        icon: Icons.food_bank,
                        name: "Product",
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Center(
                      child: Text(
                    "Manage",
                  )),
                )
              ],
            ))));
  }
}
