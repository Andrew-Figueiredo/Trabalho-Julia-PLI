using Pkg # para usar o PKG que é apra adicionar Pacotes
Pkg.add("JuMP") #Aqui se adiciona Pacotes
using JuMP #Usar Pacote  JuMP
Pkg.add("CPLEX") # Adicionar Pacote CPLEX
using CPLEX #Usar Pacote CPLEX
# Pkg.add("Cbc")
# using Cbc

n=4 #Numero de variaveis
m = Model(with_optimizer(CPLEX.Optimizer)) #Criação de um novo Modelo para Trabalharmos utilizando o CPLEX como otimizador

@variable(m, x[1:n]>=0,Int) #Adicionar variaveis x1,x2,x3,x4,......,xn >=0 no Modelo m
@expression(m,Expressao1, x[1]+4x[2]-2x[3]+8x[4] ) #Criar expression 1
@expression(m,Expressao2,-x[1] + 2x[2]+3x[3]+4x[4] )#Criar expression 2



@objective(m, Max, 2x[1]-4x[2]+5x[3]-6x[4] ) #Criar função objetico
@constraint(m, Expressao1<= 2.0 ) #Criar Restricao 1
@constraint(m, Expressao2<= 1.0 ) #Criar Restricao 2

print(m) #Printar o Modelo

 status = optimize!(m) # Resolver o Modelo
println("Objective value: ", objective_value(m)) #Printar o valor objetivo
for i = 1:n
    println("x",i," = ",value(x[i])) # Printando os valroes de x
end
