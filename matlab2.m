%Método de Newton-Rhapson (versión interactiva)
%Ingresa los datos de entrada para encontrar la raíz de una función y presiona 
%Enter repetidas veces para ver el proceso paso a paso.

clc; clear all;
%^*
% x^3 - 9*x^2 + 10*x + 2 = Funcion para verificar
f = 'cos(x) + x'; %Función dependiente de x.
fs = str2sym(f); %Convierte el string a función simbólica.
vs = symvar(fs); %Detecta la variable simbólica.
dfs = diff(fs,vs,1); %Calcula la primera derivada.

fplot(fs,'k-','LineWidth',2); %Grafica la función de color negro y grosor 2
title(f); hold on; grid on; %Título de la función.
line([-5 5],[0 0],'Color','k','LineStyle','--'); %Marca el eje X.
line([0 0],[-5 5],'Color','k','LineStyle','--') %Marca el eje Y.

xi = 5; %Valor inicial.
contador=12; %Número de máximo de iteraciones.
Tol=0.01; %Tolerancia para el criterio de convergencia a superar o igualar (%)


%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~Algoritmo~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

obj = plot(xi,subs(fs,vs,xi),'ko','markerfacecolor','b'); %Grafica los límites como puntos
fprintf('Presiona una tecla para continuar\n'); pause;

for i = 1:contador
    
    dfdx = double(subs(dfs,vs,xi(i)));
    fseval = double(subs(fs,vs,xi(i)));
    xi(i+1) = xi(i) - fseval/dfdx; %Calcula la siguiente iteración de la raíz.
    ea(i+1) = abs((xi(i+1) - xi(i)) / xi(i+1)) * 100; %Calcula el error aproximado actual.
    dfunc = poly2sym([dfdx,(dfdx * -xi(i))+fseval],vs); %Calcula la recta tangente y graficala.
        
    %Grafica nuevos puntos
    obj1 = plot(xi(i+1),subs(fs,vs,xi(i+1)),'ko','markerfacecolor','r'); %Grafica el punto medio actual.
    obj2 = fplot(dfunc,'Color','r');
    obj3 = plot([xi(i+1),xi(i+1)],[0,subs(fs,vs,xi(i+1))],'r--');
    fprintf('Presiona una tecla para continuar\n'); pause;
    
    % Grafica el nuevo intervalo
    delete(obj1); delete(obj2); delete(obj3);%Borra el punto medio actual y su línea de apoyo
    set(obj,'markerfacecolor','w'); %Vuelve blanco el punto que ya no nos sirve
    obj = plot(xi(i+1),subs(fs,vs,xi(i+1)),'ko','markerfacecolor','b'); %Actualiza los límites
    fprintf('Presiona una tecla para continuar\n'); pause;
    
    if i >= 2
        if xi(i+1) == xi(i-1)
            osc = osc + 1;
            if osc == 3
                error('Divergencia oscilatoria detectada. Use otro valor inicial de x');
            end
        end
    end
    
    if i >= 30 && ea(i+1) > es
        error('Convergencia lenta o divergencia detectada. Use otro valor inicial de x');
    end
      
    if ea(i+1) < Tol  || isnan(ea(i+1)) %Si el error aproximado es menor a la tolerancia exigida, se acaba el ciclo.
        fprintf('Convergencia!\n');
        break;
    end
end

%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Resultados~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

Raiz = xi(end)
Error = ea(end)
Numero_iteraciones = i+1