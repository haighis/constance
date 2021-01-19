# Database Design
Constance uses a SQLite database to provide an embedded database for our personal desktop network monitoring
needs. Constance intends to monitor 100s of monitor items which should fit into the use cases of SQLite. See
https://www.sqlite.org/whentouse.html By using close to a relational model in SQLite we are ready for the future 
if we need to store monitors in a RDBMS or other ecto friendly data store in the future.

Constance is using the Elixir ORM ecto called sqlite_ecto2 https://github.com/elixir-sqlite/sqlite_ecto2

# Entities

There are two entities in Constance that are Item and Setting. 

Item

An Item is a Monitor Item with string fields: name, type and details. Details stores any JSON. 
An Item can be any type of monitor item such as a http website, database host, network host. A monitor is
not specific to an http check. The design of a monitor item is important that is should be generic to
support any type of monitor item whether database host, network host that is determined by its type. 

There are currently only one type that is a string value httpv1.

For example other types could be networkhostv1 or databasehostv1

Setting

A setting has string fields key and value to create a generic storage of configurating settings that are consumed in
Constance.