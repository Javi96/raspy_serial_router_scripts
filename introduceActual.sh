#! /bin/bash

identTTY=$1
identTIME=$2

contenido=0
masactual=0

conectadosFILE="ficheros/conectados"
temporal="ficheros/temporal"

demoPID=0
esta=0
i=0 # probar si comienza en 0 o 1. Falta comando LET
while IFS=' ' read timeRead ident pidREAD
do
#echo "time : $timeRead parametro: $identTIME\n\
#ident : $ident parametro: $identTTY"
if [ "$ident" = "$identTTY" ];
then
esta=1
#echo "$timeRead TIEMPOFICHERO \n $identTIME TIEMPOPARAMETRO"
if test $timeRead -lt $identTIME
then
echo "ESTE ES EL PROCESO A ELIMINAR $pidREAD"
kill -9 $pidREAD
echo "SE BORRA LA LINEA $i"
# linea comentada porque falta comando LET
#sed -i "/$i/d" $conectadosFILE
echo " IEPALE $identTTY"
sed -i "/$identTTY/d" $conectadosFILE > $temporal
python conexion.py $identTTY &
demoPID=$!

echo " ESTO LO QUE NOS INTERESA!!!!!!! $identTTY"
echo "ESTE ES EL PROCESO A ANIADIR $demoPID"
echo $identTIME $identTTY $demoPID >> $conectadosFILE
echo "ANIADIDO A FICHERO"
else
echo "ESTOY EN EL PROCESO BUENO"
fi
fi
#let i=$i+1
done < $conectadosFILE
if test $esta -eq 0
then
python conexion.py $identTTY &
demoPID=$!
echo "ESTE ES EL PROCESO $demoPID"
echo $identTIME $identTTY $demoPID >> $conectadosFILE
echo "ANIADIDO A FICHERO"
fi
