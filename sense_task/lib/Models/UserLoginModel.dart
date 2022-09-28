class UserLogin{
  String? uid;
  String? username;

  UserLogin({this.uid,this.username});
}
class CollectionTask {
  String? uid;
  String? categorydb;
  String? titledb;
  String? descriptiondb;
  String? startdatedb;
  String? enddatedb;
  String? duedatedb;
  String? duetimedb;
  String? facultydb;
  int? statusdb;
  String? reasondb;

  CollectionTask(
      {this.uid, this.categorydb, this.titledb, this.descriptiondb, this.startdatedb, this.enddatedb, this.duedatedb, this.facultydb, this.statusdb, this.reasondb}
      );
}
