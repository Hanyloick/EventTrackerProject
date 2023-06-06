# EventTrackerProject

<br>
This Project Allows The user to perform Basic Crud operations on a MySQL database table using REST APIs in Postman<br>

http://18.216.79.214:8080<br> 

<br>

# Endpoints

	| HTTP Verb | URI                  | Request Body | Response Body | Purpose |
	|-----------|----------------------|--------------|---------------|---------|
	| GET       | `/api/cards`      |              | Collection of representations of all _Card_ resources | **List** all Cards |
	| GET       | `/api/cards/17`   |              | Representation of _Card_ `17` | **Retrieve** endpoint |
	| POST      | `/api/cards`      | Representation of a new _Card_ resource | Description of the result of the operation | **Create** endpoint |
	| PUT       | `/api/cards/17`   | Representation of a new version of _Card_ `17` | | **Replace** endpoint |
	| DELETE    | `/api/cards/17`   |              | | **Delete** route |

<br>

	| HTTP Verb | URI                  | Request Body | Response Body | Purpose |
	|-----------|----------------------|--------------|---------------|---------|
	| GET       | `/api/purchases`     |              | Collection of representations of all _Purchase_ resources | **List** all Purchases |
	| GET       | `/api/purchases/1`   |              | Representation of _Purchase_ `1` | **Retrieve** endpoint |
	| POST      | `/api/purchases`     | Representation of a new _Purchase_ resource | Description of the result of the operation | **Create** endpoint |
	| PUT       | `/api/purchases/1`   | Representation of a new version of _Purchase_ `1` | | **Replace** endpoint |
	| DELETE    | `/api/purchases/1`   |              | | **Delete** route |

<br>

	| HTTP Verb | URI                  | Request Body | Response Body | Purpose |
	|-----------|------------------|--------------|---------------|---------|
	| GET       | `/api/users`     |              | Collection of representations of all _User_ resources | **List** all Users
	| GET       | `/api/users/1`   |              | Representation of _User_ `1` | **Retrieve** endpoint |
	| POST      | `/api/users`     | Representation of a new _User_ resource | Description of the result of the operation | **Create** endpoint |
	| PUT       | `/api/users/1`   | Representation of a new version of _User_ `1` | | **Replace** endpoint |
	| DELETE    | `/api/users/1`   |              | | **Delete** route |

<br>

	| HTTP Verb | URI                  | Request Body | Response Body | Purpose |
	|-----------|----------------------------|--------------|---------------|---------|
	| GET       | `/api/inventoryItems`      |              | Collection of representations of all _InventoryItem_ resources | **List** all Inventory Items
	| GET       | `/api/inventoryItems/1`   |              | Representation of _InventoryItem_ `1` | **Retrieve** endpoint |
	| POST      | `/api/inventoryItems`      | Representation of a new _InventoryItem_ resource | Description of the result of the operation | **Create** endpoint |
	| PUT       | `/api/inventoryItems/1`   | Representation of a new version of _InventoryItem_ `1` | | **Replace** endpoint |
	| DELETE    | `/api/inventoryItems/1`   |              | | **Delete** route |

<br>	

# Technologies Used

<br>
*Java,<br>
*Spring Boot,<br> 
*Spring Data,<br> 
*SQL,<br> 
*REST,<br> 
*JSON,<br> 
*Postman,<br> 
*MySQL Workbench<br>

# Lessons Learned

I learned how to utilize REST(representational state transfer) APIs in postman<br> to test Repository, Service, and Controller method implementatons.