#!/bin/bash



PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


echo -e "\nRaname weight/atomic_mass"
echo "$($PSQL "alter table properties rename column weight to atomic_mass")"

echo -e "\nRaname melting_point/melting_point_celsius"
echo "$($PSQL "alter table properties rename column melting_point to melting_point_celsius;")"

echo -e "\nRaname boiling_point/boiling_point_celsius"
echo "$($PSQL "alter table properties rename column boiling_point to boiling_point_celsius;")"
                                                      
echo -e "\nMelting_point_celsius set not null"
echo "$($PSQL "alter table properties alter column melting_point_celsius set not null;")"

echo -e "\nBoiling_point_celsius set not null"
echo "$($PSQL "alter table properties alter column boiling_point_celsius set not null;")"


echo "$($PSQL "ALTER TABLE elements ADD CONSTRAINT constraint_symbol UNIQUE (symbol);")"
echo "$($PSQL "ALTER TABLE elements ADD CONSTRAINT constraint_name UNIQUE (name);")"


echo -e "\nSymbol set not null"
echo "$($PSQL "alter table elements alter column symbol set not null;")"

echo -e "\nSymbol name not null"
echo "$($PSQL "alter table elements alter column name set not null;")"

echo -e "\nADD CONSTRAINT"
echo "$($PSQL "ALTER TABLE properties DROP CONSTRAINT properties_elements_atomicnumber_fkey;")"
echo "$($PSQL "ALTER TABLE properties ADD CONSTRAINT properties_elements_atomicnumber_fkey FOREIGN KEY(atomic_number) references elements(atomic_number);")"

echo "$($PSQL "drop table types;")"
echo "$($PSQL "create table types();")"
echo "$($PSQL "ALTER TABLE types ADD COLUMN type_id int PRIMARY KEY not null")"
echo "$($PSQL "ALTER TABLE types ADD COLUMN type varchar(20) not null")"



## Insert
echo "$($PSQL "insert into types (type_id, type) values (1,'nonmetal')")"
echo "$($PSQL "insert into types (type_id, type) values (2,'metal')")"
echo "$($PSQL "insert into types (type_id, type) values (3,'metalloid')")"

echo "$($PSQL "ALTER TABLE properties ADD COLUMN type_id int")"
echo "$($PSQL "ALTER TABLE properties ADD CONSTRAINT properties_types_type_fkey FOREIGN KEY(type_id) references types(type_id);")"



echo "$($PSQL "update properties set type_id = 1 where type = 'nonmetal'")"
echo "$($PSQL "update properties set type_id = 2 where type = 'metal'")"
echo "$($PSQL "update properties set type_id = 3 where type = 'metalloid'")"

echo "$($PSQL "ALTER TABLE properties alter COLUMN type_id set not null")"

echo "$($PSQL "update elements set symbol = 'H'  where atomic_number = 1")"
echo "$($PSQL "update elements set symbol = 'He'  where atomic_number = 2")"
echo "$($PSQL "update elements set symbol = 'Li'  where atomic_number = 3")"
echo "$($PSQL "update elements set symbol = 'Be'  where atomic_number = 4")"
echo "$($PSQL "update elements set symbol = 'B'  where atomic_number = 5")"
echo "$($PSQL "update elements set symbol = 'C'  where atomic_number = 6")"
echo "$($PSQL "update elements set symbol = 'N'  where atomic_number = 7")"
echo "$($PSQL "update elements set symbol = 'O'  where atomic_number = 8")"
echo "$($PSQL "update elements set symbol = 'MT'  where atomic_number = 1000")"

echo $($PSQL "ALTER TABLE properties alter column atomic_mass type REAL;")


echo "$($PSQL "insert into elements (atomic_number, symbol, name) values (9,'F', 'Fluorine')")"
echo "$($PSQL "insert into properties (atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) values (9,'nonmetal',18.998,-220,-188.1,1)")"

echo "$($PSQL "insert into elements (atomic_number, symbol, name) values (10,'Ne', 'Neon')")"
echo "$($PSQL "insert into properties (atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) values (10,'nonmetal',20.18,-248.6,-246.1,1)")"

echo "$($PSQL "delete from properties where atomic_number = 1000;")"

