import serial
import sys
import time

miTTY = sys.argv[1]

miport = serial.Serial("/dev/"+miTTY, baudrate=115200, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS  , timeout=1.0)

salida = open('ficheros/logger', 'w')
salida.write('comienza el log\n')
print "comienza el log\n"
while True:
        lectura = miport.readline()
        if (lectura != ""):
                mensajeFULL = lectura.split('P')[0]
				idDestino = mensajeFULL.split(';')[0]
				mensaje = mensajeFULL.split(';')[1]
                salida.write('lectura ------>  '+lectura+' / mensajote ----> '+mensaje+'\n')
                print "lectura ------>  " + lectura + " / mensajote ----> " + mensaje + "\n"
                f = open('ficheros/conectados', 'r')
				destinoTTY='ttyUSB'+idDestino
				if(destinoTTY!=miTTY):
						for line in f:
								partes = line.split(' ')
								otroTTY = partes[1]
								salida.write('el otro: '+otroTTY+'\n')
								print "el otro: " + otroTTY + "\n"
								if (otroTTY==destinoTTY):
										otroport = serial.Serial("/dev/"+otroTTY, baudrate=115200, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS  , timeout=3.0)
										otroport.open()
										otroport.isOpen()
										menAux=mensaje+'P\r'
										print 'menAuxer:   --- ' + menAux + '\n'
										otroport.write(menAux)
										salida.write('escribimos ---->'+mensaje+'P\n')
										print "escribimos -->"+mensaje+"P\n"
										otroport.close()
						f.close()