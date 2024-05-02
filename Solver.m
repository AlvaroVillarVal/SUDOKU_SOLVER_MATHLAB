classdef Solver
    methods
        function obj = Solver()
            % Constructor de la clase Solver.
            % Inicialmente, no se necesita realizar ninguna acción específica en el constructor.
        end
        
        function sudoku = resolverSudoku(obj, sudoku)
            % Método para resolver un puzzle de Sudoku utilizando el enfoque de backtracking.
            %
            % Entradas:
            %   - obj: la instancia de la clase Solver.
            %   - sudoku: matriz de 9x9 representando el estado actual del Sudoku.
            %
            % Salidas:
            %   - sudoku: matriz de 9x9 resuelta del Sudoku, si es solucionable.

            % Encuentra la primera celda vacía (donde el valor es cero).
            [fila, col] = find(sudoku == 0, 1);
            
            % Si no hay celdas vacías, el sudoku está resuelto.
            if isempty(fila)
                return;
            end
            
            % Prueba todos los números del 1 al 9 en la celda vacía encontrada.
            for num = 1:9
                if obj.esValido(sudoku, fila, col, num)
                    sudoku(fila, col) = num;  % Asigna el número a la celda.
                    
                    % Llama recursivamente a resolverSudoku.
                    sudoku = obj.resolverSudoku(sudoku);
                    
                    % Si se resuelve el sudoku, retorna el resultado.
                    if all(sudoku(:) > 0)
                        return;
                    end
                    
                    % Si no es solución, restablece la celda y prueba con otro número.
                    sudoku(fila, col) = 0;
                end
            end
        end
        
        function valido = esValido(~, sudoku, fila, col, num)
            % Método para verificar si un número dado puede ser colocado en la posición dada sin violar las reglas del Sudoku.
            %
            % Entradas:
            %   - sudoku: matriz actual del Sudoku.
            %   - fila: índice de fila de la celda a verificar.
            %   - col: índice de columna de la celda a verificar.
            %   - num: número a verificar.
            %
            % Salidas:
            %   - valido: booleano, true si el número puede ser colocado, false de lo contrario.

            % Verifica si el número ya está en la fila.
            if any(sudoku(fila, :) == num)
                valido = false;
                return;
            end
            
            % Verifica si el número ya está en la columna.
            if any(sudoku(:, col) == num)
                valido = false;
                return;
            end
            
            % Determina el bloque 3x3 y verifica si el número ya está en el bloque.
            filaInicio = floor((fila - 1) / 3) * 3 + 1;
            colInicio = floor((col - 1) / 3) * 3 + 1;
            if any(num == sudoku(filaInicio:filaInicio+2, colInicio:colInicio+2), 'all')
                valido = false;
                return;
            end
            
            % Si pasa todas las verificaciones, el número es válido para la celda.
            valido = true;
        end
    end
end
