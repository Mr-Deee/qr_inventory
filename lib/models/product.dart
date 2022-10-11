class Product {
    Product({
        this.barcode,
        this.name,
        this.cost,
        this.group,
        this.location,
        this.company,
        this.quantity,
        this.image,
        this.description,
        this.year,
        this.month,
    });

    String? name;
    String? barcode;
    double? cost;
    String? group;
    String? location;
    String? company;
    int? month;
    int? year;
    int? quantity;
    String? image;
    String? description;

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        name: json["name"] as String?,
        cost: json["cost"] as double?,
        group: json["group"] as String?,
        location: json["location"] as String?,
        company: json["company"] as String?,
        quantity: json["quantity"] as int?,
        barcode: json["barcode"] as String?,
        year: json["expiryyear"]  as int?,
        month: json["expirymonth"]  as int?,
       // image: json["image"] as String?,
        description: json["description"] as String?,
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "cost": cost,
        "group": group,
        "location": location,
        "company": company,
        "quantity": quantity,
        "expiryyear":year,
        "expirymonth":month,

       // "image": image,
        "description": description,
    };
}
