#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
if [[ -z $1 ]]
then 
  echo -e "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    CHECK=$($PSQL "SELECT e.atomic_number,e.name,e.symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius FROM elements AS e FULL JOIN properties AS p ON e.atomic_number=p.atomic_number FULL JOIN types AS t ON p.type_id=t.type_id WHERE e.atomic_number=$1 ")
    if [[ -z $CHECK ]]
    then
      echo "I could not find that element in the database."
    else
      echo $($PSQL "SELECT e.atomic_number,e.name,e.symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius FROM elements AS e FULL JOIN properties AS p ON e.atomic_number=p.atomic_number FULL JOIN types AS t ON p.type_id=t.type_id WHERE e.atomic_number=$1 ") | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
    
  elif [[ $1 =~ ^[A-Z][a-z]$ || $1 =~ ^[A-Z]$ ]]
  then
    CHECK=$($PSQL "SELECT e.atomic_number,e.name,e.symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius FROM elements AS e FULL JOIN properties AS p ON e.atomic_number=p.atomic_number FULL JOIN types AS t ON p.type_id=t.type_id WHERE e.symbol='$1' ")
    if [[ -z $CHECK ]]
    then
      echo "I could not find that element in the database."
    else
      echo $($PSQL "SELECT e.atomic_number,e.name,e.symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius FROM elements AS e FULL JOIN properties AS p ON e.atomic_number=p.atomic_number FULL JOIN types AS t ON p.type_id=t.type_id WHERE e.symbol='$1' ") | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  elif [[ $1 =~ ^[A-Z][a-z][a-z]*$ ]]
  then
    CHECK=$($PSQL "SELECT e.atomic_number,e.name,e.symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius FROM elements AS e FULL JOIN properties AS p ON e.atomic_number=p.atomic_number FULL JOIN types AS t ON p.type_id=t.type_id WHERE e.name='$1' ")
    if [[ -z $CHECK ]]
    then
      echo "I could not find that element in the database."
    else
      echo $($PSQL "SELECT e.atomic_number,e.name,e.symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius FROM elements AS e FULL JOIN properties AS p ON e.atomic_number=p.atomic_number FULL JOIN types AS t ON p.type_id=t.type_id WHERE e.name='$1' ") | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  else
    echo "I could not find that element in the database."
  fi
fi