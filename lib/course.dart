class Course {
  int id,students;
  String name,profesor;
  Course(this.id,this.name,this.profesor,this.students);
 factory Course.fromJson(Map<String, dynamic> json){
return Course(
      
       json['id'],
       json['name'],
      json['professor'],
      json['students']
    );
  }
}