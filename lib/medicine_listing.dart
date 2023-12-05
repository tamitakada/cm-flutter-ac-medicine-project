class MedicineListing{

  String? brandName;
  String? purpose;
  List<dynamic>? warnings; //warnings + do_not_use
  String? directions;
  String? route;
  List<dynamic>? ingredients;//active_ingredients + spl_product_data_elements

  MedicineListing({

    this.brandName,
    this.purpose,
    this.warnings,
    this.directions,
    this.route,
    this.ingredients,

  });
}
