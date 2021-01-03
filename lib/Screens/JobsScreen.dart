import 'package:github_jobs_app/models/Job.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_jobs_app/Screens/JobDetails.dart';

Future<List<Job>> fetchJob() async {
  final response = await http.get('https://jobs.github.com/positions.json');
  if (response.statusCode == 200) {
    var decodeData = jsonDecode(response.body) as List;
    List<Job> listJob = decodeData.map((json) => Job.fromJson(json)).toList();
    return listJob;
  } else {
    throw Exception('Fail to fetch list jobs!');
  }
}

class JobsScreen extends StatefulWidget {
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final String title = 'Github Jobs';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Job>> jobBank;

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  Widget getCompanyLogo(String url) {
    if (url == null) {
      return Icon(
        Icons.image,
        size: 70,
      );
    } else {
      return CachedNetworkImage(
        errorWidget: (context, imageUrl, _) => Icon(
          Icons.image,
          size: 70,
        ),
        alignment: Alignment.center,
        height: 120,
        fit: BoxFit.contain,
        placeholder: (context, imageUrl) => CupertinoActivityIndicator(),
        imageUrl: url,
      );
    }
  }

  Widget builderContent() => FutureBuilder<List<Job>>(
        future: jobBank,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<String> categories = [
              'NodeJS',
              'Angular',
              'PHP',
              'iOS',
              'Android',
              'Python'
            ];
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(title),
                  floating: true,
                  pinned: false,
                  flexibleSpace: Container(
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      title: SizedBox(
                        height: 18,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  categories[index],
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  width: 15,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  expandedHeight: 100,
                  leading: IconButton(
                    icon: Icon(Icons.list_sharp),
                    onPressed: _openDrawer,
                  ),
                  actions: [
                    Stack(
                      children: [
                        IconButton(
                          icon: Icon(Icons.card_travel),
                          onPressed: () {},
                        ),
                        Positioned(
                          top: 5,
                          right: 3,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text('1'),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 5.0,
                    )
                  ],
                ),
                CupertinoSliverRefreshControl(
                  onRefresh: fetchJob,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                JobDetails(snapshot.data[index]),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Hero(
                                tag: "${snapshot.data[index].id}",
                                child: getCompanyLogo(
                                    snapshot.data[index].companyLogo),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.person_search_outlined),
                              title: Text(
                                snapshot.data[index].title,
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.business_outlined),
                              title: Text(
                                snapshot.data[index].company,
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.timer),
                              title: Text(
                                snapshot.data[index].type,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    childCount: snapshot.data.length,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Text('Error while fetch data!!'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

  @override
  void initState() {
    super.initState();
    jobBank = fetchJob();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: builderContent(),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 70,
                    ),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Your name goes here!'),
                ],
              ),
            ),
            ListTile(
              title: Text('My Skills'),
            ),
            ListTile(
              title: Text('History'),
            ),
            Divider(),
            ListTile(
              title: Text('About'),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Header'),
            ),
            ListTile(
              title: Text('First Menu Item'),
            ),
            ListTile(
              title: Text('Second Menu Item'),
            ),
            Divider(),
            ListTile(
              title: Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}
