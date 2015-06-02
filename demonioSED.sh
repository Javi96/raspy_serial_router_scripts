while true;
do
dmesg | tail -n 300 | grep "FTDI USB Serial Device converter now attached to" | awk '{regTTY="ttyUSB[0-9]+";if (match($0,regTTY)); \
        patronTTY = substr($0,(RSTART-1),RLENGTH+1); \
        regTIME="[0-9]+";if (match($0,regTIME)); if (match($0,regTIME)); \
        patronTIME = substr($0,(RSTART-1),RLENGTH+1); \
        printf("%s:+:%s\n",patronTTY,patronTIME); system("./introduceActual.sh "patronTTY" "patronTIME)}'
dmesg | tail -n 300 | grep "FTDI USB Serial Device converter now disconnected from"  | awk '{regTTY="ttyUSB[0-9]+";if (match($0,regTTY)); \
        patronTTY = substr($0,(RSTART-1),RLENGTH+1); \
        regTIME="[0-9]+";if (match($0,regTIME)); if (match($0,regTIME)); \
        patronTIME = substr($0,(RSTART-1),RLENGTH+1); \
        printf("%s:-:%s\n",patronTTY,patronTIME); system("./eliminarActual.sh "patronTTY" "patronTIME)}'
sleep 1
done
