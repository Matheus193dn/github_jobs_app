class Job {
  final String id;
  final String type;
  final String url;
  final String createAt;
  final String company;
  final String companyUrl;
  final String location;
  final String title;
  final String description;
  final String howToApply;
  final String companyLogo;

  Job({
    this.id,
    this.type,
    this.url,
    this.createAt,
    this.company,
    this.companyUrl,
    this.location,
    this.title,
    this.description,
    this.howToApply,
    this.companyLogo,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      type: json['type'],
      url: json['url'],
      createAt: json['created_at'],
      company: json['company'],
      companyUrl: json['company_url'],
      location: json['location'],
      title: json['title'],
      description: json['description'],
      howToApply: json['how_to_apply'],
      companyLogo: json['company_logo'],
    );
  }
}
