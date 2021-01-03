import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:github_jobs_app/models/Job.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';

class JobDetails extends StatelessWidget {
  final Job inputJob;

  JobDetails(this.inputJob);

  Widget getCompanyLogo(String url) {
    if (url == null) {
      return Icon(
        Icons.image,
        size: 70,
      );
    } else {
      return CachedNetworkImage(
        fit: BoxFit.fill,
        placeholder: (context, imageUrl) => CupertinoActivityIndicator(),
        imageUrl: url,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(inputJob.company),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Hero(
                  tag: "${inputJob.id}",
                  child: getCompanyLogo(inputJob.companyLogo),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person_search_outlined),
                title: Text(
                  inputJob.title,
                ),
              ),
              ListTile(
                leading: Icon(Icons.timer),
                title: Text(
                  inputJob.type,
                ),
              ),
              Html(
                data: inputJob.description,
                style: {
                  "html": Style(
                    fontSize: FontSize(
                      15,
                    ),
                  ),
                },
                onLinkTap: (url) {
                  print("Opening $url...");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
