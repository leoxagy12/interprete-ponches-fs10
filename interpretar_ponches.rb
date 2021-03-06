#!/usr/bin/ruby

#Ejemplo de llamada de script: 
#ruby interpretar_ponches.rb PONCHES.TXT 2012 02 03 04 10012

require 'date'

nom_archi = ARGV[0] #archivo de ponches extraido de reloj 
ano = ARGV[1].to_i 
mes = ARGV[2].to_i
d_i = ARGV[3].to_i #dia inicial
d_f = ARGV[4].to_i #dia final
n_i = ARGV[5].to_i #codigo de persona que poncha de la cual se desea sacar datos

puts "- Condiciones de filtro -"  
print "En el archivo de ponches: " + nom_archi
print ", para el ano " + ano.to_s
print ", mes " + mes.to_s
print ". Del dia " + d_i.to_s + " al " + d_f.to_s 
print ". Para el Individuo: " + n_i.to_s
puts "."
puts "Se tienen los siguientes ponches: "

counter = 1



begin

    file = File.new(nom_archi, "r")
    file.gets #saltar primera linea... solo tiene los nombres de las columnas en el archivo...
    while (line = file.gets)
        ar = line.split("\t")

	num_ponche = ar[0].to_i
	num_individuo = ar[2].to_i
	fecha = DateTime.strptime(ar.last.chop,"%Y-%m-%d %H:%M:%S")

	str_fecha = fecha.strftime("%d/%m/%Y - %I:%M%p")
	if num_individuo == n_i and fecha.year == ano and fecha.mon == mes  and fecha.day >= d_i and fecha.day <= d_f
		puts "Ponche ##{num_ponche} \t-    Individuo ##{num_individuo} \t <#{str_fecha}>"
	end 

        counter = counter + 1
    end
    puts "Numero de ponches leidos: #{counter}"
    file.close
rescue => err
    puts "Excepcion: #{err}"
    err
end
