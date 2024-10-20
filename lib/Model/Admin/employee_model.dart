class Employee {
  final Role roleId;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String aadhaarNo;
  final String photo;
  final bool isActive;
  final int createdBy;
  final int updatedBy;
  final String userName;
  final String password;

  Employee({
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.aadhaarNo,
    required this.photo,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.userName,
    required this.password,
  });

  // You can add a method to convert to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'roleId': {
        'id': roleId.id,
      },
      'firstName': firstName,
      'lastName': lastName,
      'mobileNo': mobileNo,
      'aadhaarNo': aadhaarNo,
      'photo': photo,
      'isActive': isActive,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'userName': userName,
      'password': password,
    };
  }
}

class Role {
  final int id;
  final String label;

  Role({required this.id, required this.label});
}
