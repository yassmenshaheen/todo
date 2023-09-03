class TaskModle{
   String id;
   String title;
   String description;
   int date;
   bool isDone;
   String userId;

   TaskModle({ required this.description
      ,required this.title
      , this.id="", required
       this.date,
     required this.userId,
      this.isDone=false});
   TaskModle.fromJson(Map<String,dynamic>json)
       :this(
         id:json['id'],
         title:json['title'],
         description: json['description'],
         date:json['date'],
         isDone:json['isDone'],
     userId:json['userId'],);
   Map<String,dynamic>toJson(){
      return {
         "id": id,
         "title": title,
         "description": description,
         "date": date,
         "isDone": isDone,
        "userId": userId,

      };
   }


}