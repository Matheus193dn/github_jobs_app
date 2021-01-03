import 'package:github_jobs_app/models/Job.dart';

class Jobs {
  List<Job> _jobBank = [];

  int get numbOfJobs => _jobBank.length;
  Job jobAtIndex(int index) => _jobBank[index];
}
