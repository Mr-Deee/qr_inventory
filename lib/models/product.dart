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
        this.Expiry,

    });

    String? name;
    String? barcode;
    double? cost;
    String? group;
    String? location;
    String? company;
    int? month;
    String? Expiry;
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
        Expiry: json["ExpiryDate"]  as String?,

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
        "ExpiryDate":Expiry,


       // "image": image,
        "description": description,
    };
}
