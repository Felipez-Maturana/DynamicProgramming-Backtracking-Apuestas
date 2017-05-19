require "csv"
def backtrackingApuestas(apuestas,gananciasAUX,dia,combinacion,combinacionAUX,gananciaMax)
	if(dia==apuestas.length-1)
		puts "*******************BACKTRACKING***********************"
		puts "La ganancia máxima es: #{gananciaMax}"
		puts "Jugando desde el día #{combinacionAUX[0]} hasta #{combinacionAUX[combinacionAUX.length-1]}"
		puts "*****************************************************"
		# print combinacionAUX
		return gananciaMax
	end
	gananciasAUX=gananciasAUX+apuestas[dia]
	if(gananciasAUX>gananciaMax)
		if(!combinacion.include?dia+1)
			combinacion.push(dia+1)
		end

		combinacionAUX=combinacion.clone
		gananciaMax=gananciasAUX
	end


	if(gananciasAUX>=apuestas[dia])
		combinacion.push(dia+1)
		backtrackingApuestas(apuestas,gananciasAUX,dia+1,combinacion,combinacionAUX,gananciaMax)
	else
		combinacion=[]
		combinacion.push(dia+1)
		backtrackingApuestas(apuestas,apuestas[dia],dia+1,combinacion,combinacionAUX,gananciaMax)
	end

end
def corroborar(apuestas,cotaI, cotaS)
	acumulador=0
	sumados=[]
	while(cotaI-1<=cotaS-1)
		acumulador+=apuestas[cotaI-1]
		sumados.push(cotaI)
		cotaI+=1
	end
	print sumados
	puts acumulador
end

def dinamicProgrammingApuestas(apuestas)
	matriz = Array.new(30) { Array.new(30) }
	i=0
	while(i<matriz.length)
		matriz[i][i]=apuestas[i]
		i+=1
	end
	i=0
	j=1
	contador=0
	while(i!=0 || j!=29)
		if(j>i)
			while(j<30)
				a=matriz[i][j-1]
				b=matriz[j][j]
				matriz[i][j]=a+b
				

				j+=1
				i+=1
			end

			contador+=1
			i=0
			j=contador+1
		else
			j+=1
		end
	end
	matriz[0][29]=matriz[0][28]+matriz[29][29]
	CSV.open("file.csv", "w") do |csv|
	 	i=0
	 	while(i<30)
	 		csv << matriz[i]
	 		i+=1
	 	end
 	end
 # 	puts "a"
	# print matriz[0][28]
	diaInicial=0
	diaFinal=0
	i=0
	j=0
	max=matriz[0][0]
	while(i<30)
		j=0
		while(j<30)
			if(!matriz[i][j].nil? && matriz[i][j]>max)
				max=matriz[i][j]
				diaInicial=i+1
				diaFinal=j+1
			end
			j+=1
		end
		i+=1
	end
	puts "*************DYNAMIC PROGRAMMING*********************"
	puts "La ganancia máxima es: #{max}"
	puts "Jugando desde el día #{diaInicial} hasta #{diaFinal}"
	puts "*****************************************************"
end


apuestas=[29,-7,14,21,30,-47,1,7,-39,23,-20,-36,0,27,-34,7,48,35,-46,-16,32,18,5,-33,27,28,-22,1,-20,-42]
backtrackingApuestas(apuestas,0,0,[],[],0)
dinamicProgrammingApuestas(apuestas)