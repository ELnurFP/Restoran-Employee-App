import 'package:template/models/base_res_model.dart';


class GetUserStatusTypeResModel extends BaseResModel {
    GetUserStatusTypeResModel({
         this.types,
    });

    List<UserType>? types;

}

class UserType {
    UserType({
        this.id,
        this.name,
    });

    String? id;
    String? name;


    factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        id: json["id"],
        name: json["name"] 
        
    );
}
