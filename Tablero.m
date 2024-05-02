classdef Tablero < handle
    properties
        tablero;      % Almacena el estado actual del tablero
        tableroOrg;   % Almacena el estado original del tablero (números fijos)
    end

    methods
        function obj = Tablero(tab)
            % Constructor que inicializa el tablero con la matriz proporcionada.
            obj.tablero = tab;
        end
        
        function compr = actTablero(obj, fila, columna, num)
            % Actualiza el tablero en la posición especificada con el número dado
            % si es válido realizar el cambio.
            %Entradas:
            %   - obj: la instancia de la clase tablero.
            %   -fila:fila de la celda que queremos cambiar
            %   -columna: columna de la celda que queremos cambiar
            %   -num:Numero que queremos poner en la celda
            %Salidas:
            %   -compr:Devuelve true si se ha realizad el cambio correctamente y false si no se puede  
            if obj.esValido(fila, columna, num)
                obj.tablero(fila, columna) = num;
                compr = true;
            else
                compr = false;
            end
        end
        
        function tab = getTablero(obj)
            % Devuelve el estado actual del tablero.
            %Entradas:
            %   -obj: la instancia de la clase tablero.
            %Salidas:
            %   -tab: devuelve el estado del tablero en el momento actual.
            tab = obj.tablero;
        end
        
        function valido = esValido(obj, fila, col, num)
            % Verifica si es válido colocar el número 'num' en la posición (fila, col).
            %Entradas:
            %   -obj: la instancia de la clase tablero.
            %   -fila:fila de la celda que queremos comprobar
            %   -linea:linea de la celda que queremos comprobar
            %   -num: numero que queremos comprobar si se puede poner en la
            %   celda pasada
            %Salidas:
            %   -valido: Devuelve true si se puede poner y false si no

            % Comprueba si el número es parte del enunciado y no debe cambiarse.
            if ~isempty(obj.tableroOrg) && obj.tableroOrg(fila, col) ~= 0
                disp("Ese número no se puede cambiar, es parte del enunciado del sudoku que has introducido");
                valido = false;
                return;
            end
            
            % Permite que el número en una celda se elimine estableciéndolo en 0.
            if num == 0
                valido = true;
                return;
            end
            
            % Verifica que el número no esté ya en la misma fila.
            if any(obj.tablero(fila, :) == num)
                disp("Ese número ya está en esa fila");
                valido = false;
                return;
            end
            
            % Verifica que el número no esté ya en la misma columna.
            if any(obj.tablero(:, col) == num)
                disp("Ese número ya está en la columna");
                valido = false;
                return;
            end
            
            % Verifica que el número no esté ya en el cuadrado 3x3 correspondiente.
            filaInicio = floor((fila - 1) / 3) * 3 + 1;
            colInicio = floor((col - 1) / 3) * 3 + 1;
            if any(num == obj.tablero(filaInicio:filaInicio+2, colInicio:colInicio+2), 'all')
                disp("Ese número ya está en el cuadrado");
                valido = false;
                return;
            end
            
            valido = true;
        end
        
        function obj = guardartablero(obj, ~, ~, tab)
            % Guarda el enunciado del sudoku cuando se pulsa el boton de guardar
            %Entradas:
            %   -obj: la instancia de la clase tablero.
            %   -tab: recibimos el estado del tablero con el enunciado
            %   introducido
            %Salidas:
            %   -obj:devuelve el objeto tablero para poder guardar el
            %   tablero
            obj.tableroOrg = tab.getTablero();
        end

    end
end
