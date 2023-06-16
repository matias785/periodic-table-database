#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


NO_FOUND() {
    echo -e "I could not find that element in the database."
}
NO_FOUND() {
    echo -e "I could not find that element in the database."
}


if [[ -z $1 ]]
then
    echo "Please provide an element as an argument."
else
    if [[ $1 =~ ^[0-9] ]]
    then
        # 1 si es un numero
        TYPE=$($PSQL "select type from properties where atomic_number = $1;")
        ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number = $1;")
        MPC=$($PSQL "select melting_point_celsius from properties where atomic_number = $1;")
        BPC=$($PSQL "select boiling_point_celsius from properties where atomic_number = $1;")
        
        if [[ -z $TYPE ]]
        then
            NO_FOUND
        else
            echo -e "The element with atomic number 1 is Hydrogen (H). It's a $TYPE, with a mass of $ATOMIC_MASS amu. Hydrogen has a melting point of $MPC celsius and a boiling point of $BPC celsius."
        fi
        
    else
        len=`echo $1 |awk '{print length}'`
        if [[ len -lt 3 ]]
        then
            # H
            TYPE=$($PSQL "select p.type from elements e inner join properties p on e.atomic_number = p.atomic_number where e.symbol = '$1';")
            ATOMIC_MASS=$($PSQL "select p.atomic_mass from elements e inner join properties p on e.atomic_number = p.atomic_number where e.symbol = '$1';")
            MPC=$($PSQL "select p.melting_point_celsius from elements e inner join properties p on e.atomic_number = p.atomic_number where e.symbol = '$1';")
            BPC=$($PSQL "select p.boiling_point_celsius from elements e inner join properties p on e.atomic_number = p.atomic_number where e.symbol = '$1';")
            ATOMIC_NUMBER=$($PSQL "select p.atomic_number from elements e inner join properties p on e.atomic_number = p.atomic_number where e.symbol = '$1';")

            if [[ -z $TYPE ]]
            then
                NO_FOUND
            else
              echo -e "The element with atomic number $ATOMIC_NUMBER is Hydrogen (H). It's a $TYPE, with a mass of $ATOMIC_MASS amu. Hydrogen has a melting point of $MPC celsius and a boiling point of $BPC celsius."
            fi
            
        else # Igual o mayor que 3
            TYPE=$($PSQL "select p.type from elements e inner join properties p on e.atomic_number = p.atomic_number where e.name = '$1';")
            ATOMIC_MASS=$($PSQL "select p.atomic_mass from elements e inner join properties p on e.atomic_number = p.atomic_number where e.name = '$1';")
            MPC=$($PSQL "select p.melting_point_celsius from elements e inner join properties p on e.atomic_number = p.atomic_number where e.name = '$1';")
            BPC=$($PSQL "select p.boiling_point_celsius from elements e inner join properties p on e.atomic_number = p.atomic_number where e.name = '$1';")
            ATOMIC_NUMBER=$($PSQL "select p.atomic_number from elements e inner join properties p on e.atomic_number = p.atomic_number where e.name = '$1';")
            if [[ -z $TYPE ]]
            then
                NO_FOUND
            else
              echo -e "The element with atomic number $ATOMIC_NUMBER is Hydrogen (H). It's a $TYPE, with a mass of $ATOMIC_MASS amu. Hydrogen has a melting point of $MPC celsius and a boiling point of $BPC celsius."
            fi            
        fi
    fi
fi


