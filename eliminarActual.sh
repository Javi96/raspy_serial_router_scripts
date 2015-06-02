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
# busco el identificador que quiero
if [ "$ident" = "$identTTY" ];
then
esta=1
#echo "$timeRead TIEMPOFICHERO \n $identTIME TIEMPOPARAMETRO"
# Si la linea que me ha llegado es de despues de la del fichero, elimino.
if test $timeRead -lt $identTIME
then
echo "ESTE ES EL PROCESO A ELIMINAR $pidREAD"
kill -9 $pidREAD
echo "SE BORRA LA LINEA $i"
#comentada porque falta LET
#sed -i '/$i/d' $conectadosFILE
sed '/'$identTTY'/d' $conectadosFILE > $temporal
mv $temporal $conectadosFILE
else
echo "ESTOY EN EL PROCESO BUENO"
fi
fi
#let i=$i+1
done < $conectadosFILE
