#!/bin/bash

path=$(pwd)
echo $path
sudo -u postgres psql
\c suggestin
\i path/create_commets_user_cell.sql
\q
echo "succesfull"
