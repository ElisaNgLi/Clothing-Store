# Clothing-Store
Clothing Store Sample Database for DES720 group assignment. 
Enviroment used: MYSQL

# Business Narrative
This case involves a Database creation for a Web-based clothing store called “Virtual Taylor” that sells clothing for men, women and children over the Internet.
Virtual Taylor accepts orders by using company catalogs and their Web site where customers may login by using assigned userid and password.  Login authentication process is NOT of design concern. When a customer tries to place an order for a particular product (clothing item) the database application must confirm that the ordered product is in the stock. If positive, then the application must update the quantity on hand for that product from the inventory and customer will then finish that ordering process on-line. If negative, then customer must be advised when the next shipment for that particular clothing item is expected. This situation is also NOT of design concern.
On the other hand when company receives the shipment from their vendors, a clerk must update the inventory to reflect new available quantities on hand for the shipped clothing items.

Company wants to keep information about their Customers like: customer number, last name, first name, middle name, date of birth, street address, city, province, postal code, phone number, userid, password. and email address. All attributes are mandatory except the middle name and email address.
Each customer may place many Orders (or even none if prospective client) and each order will contain: order number and required order date. It will need a single payment in the form of Check (with possible post-date) or Credit Card.  System will record unique payment#,  paydate, payment method and total amount. All attributes here are mandatory ones. 
Order must exist for only one customer. 
Also, company keeps track of their Order Source whether is the specific catalog (Winter 2007, Fall 2006 etc.) or the company Web site. The primary key will be numeric id (“1”,”2”,”3”, etc)

Each clothing item (Product) will be tracked by: product code, product description and will relate to a certain Category of clothing products (Women’s, Men’s, Children’s, Outdoor etc). The primary key here will be also numeric id (“1”,”2”,”3”, etc).

Customers will fill on-line Order Lines that contain automatically assigned order number, item number (in the form first, second, third etc), quantity ordered and will relate to the Inventory situation in the company’s warehouse. All attributes here are mandatory ones.
Each Inventory item will be tracked by: inventory number, product code, color, size, price and quantity on hand. The only optional attribute is the size (and that means that this item has only one size). The primary key will be numeric id (“1”,”2”,”3”, etc). Some items may have never been purchased so far. 
Color is offered by the mean of the pick list that has the origin in the lookup table Color with only two attributes: color code and color.

Company also keeps tracks of various Shipments in the form of : ship id and expected ship date. Each order may have more than one shipment.
Each shipment may contain many inventory items that are recorded in the table called Shipment Line. When shipment arrives a clerk is taking care of Shipment Lines in the form of: ship id, inventory id, quantity shipped and date received. The primary key will be COMPOSITE NATURAL key  and the only optional attribute is date received  (if for some reason the shipment is cancelled). Some inventory items may have never been shipped so far. 

Note:  
    Create meaningful names for all attributes and use PK symbol for PK attribute(s) and  (FK) for FK ones.
     Include ALL attributes for each entity incl. composite PK attributes and every FK attribute.

    PK  attributes should be shown in BOLD font
    FK attributes should be shown in RED/ITALIC  font.
# ERD 

![DES720](https://user-images.githubusercontent.com/43829777/151437458-88c083af-82f4-4672-8d26-523be7082ba9.png)

