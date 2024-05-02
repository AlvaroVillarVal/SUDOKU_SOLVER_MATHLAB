classdef UI
    methods
        % Método para manejar clics en el tablero de Sudoku
        function celdaClick(obj, ~, ~, tablero, ax)
            %Función que controla los clicks en el tablero 
            %Entradas:
            %   -obj: la instancia de la clase UI.
            %   -tablero:Recibe la instancia del tablero en la que ha
            %   ocurrido el click
            %   -ax:devuelve el eje 
            

            % Obtener la posición del clic en las coordenadas del eje
            coords = get(ax, 'CurrentPoint');
            fila = round(coords(1, 2));
            columna = round(coords(1, 1));

            % Validar que el clic sea dentro de los límites del tablero
            if fila >= 1 && fila <= 9 && columna >= 1 && columna <= 9
                % Solicitar al usuario que ingrese un número
                num = inputdlg(sprintf('Ingrese un número (1-9) para la fila %d, columna %d:', fila, columna), ...
                               'Ingresar número', 1, {' '});
                if ~isempty(num)%si ha introducido un numero el usuario
                    num = str2double(num{1});%Comprobamos que el numero esta entre 0 y 9
                    if num >= 0 && num <= 9
                        % Actualizar el tablero con el número ingresado
                        tablero.actTablero(fila, columna, num);

                        % Redibujar el tablero con los nuevos valores
                        obj.dibujarSudoku(tablero.getTablero(), ax);
                    end
                end
            end
        end
        
        % Método para dibujar el tablero de Sudoku
        function dibujarSudoku(~, tablero, ax)
            %Función que va a dibujar el tablero cada vez que se actualice
            %Entradas:
            %   -tablero: estado del tablero que vamos a dibujar
            %   -ax: recibimos el eje

            % Limpiar el eje antes de dibujar
            cla(ax);

            % Dibujar el tablero
            imagesc(ax, -tablero);
            colormap(ax, gray);
            axis(ax, 'equal');
            axis(ax, 'off');

            % Mantener los elementos dibujados en el eje
            hold(ax, 'on');

            % Dibujar las líneas del grid, más gruesas cada tres celdas
            for x = 0.5:1:9.5
                if mod(x, 3) == 0.5
                    lw = 3; % Líneas gruesas para separar los bloques 3x3
                else
                    lw = 1; % Líneas delgadas para las celdas individuales
                end
                line(ax, [x x], [0.5 9.5], 'Color', 'k', 'LineWidth', lw);
                line(ax, [0.5 9.5], [x x], 'Color', 'k', 'LineWidth', lw);
            end

            % Identificar el número más grande en el tablero
            maxNum = max(tablero(:));

            % Poner números en el tablero
            for fila = 1:9
                for columna = 1:9
                    num = tablero(fila, columna);
                    if num ~= 0
                        % Cambiar el color para los tres numeros más grande
                        if num >= (maxNum-2)
                            text(ax, columna, fila, num2str(num), 'Color', 'white', 'FontSize', 12, ...
                                 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
                        else
                            text(ax, columna, fila, num2str(num), 'Color', 'k', 'FontSize', 12, ...
                                 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
                        end
                    end
                end
            end

            % Finalizar el hold
            hold(ax, 'off');
        end

        function botonresolver(obj, ~, ~, ax, tab)
            %Función que al pulsar el boton resuelve el sudoku
            %Entradas:
            %   -obj: la instancia de la clase UI.
            %   -ax: recibe el eje que usaremos para dibujar el tablero mas
            %   tarde
            %   -tab: Recibe el tablero a solucionar
            

            % Crear un objeto de la clase Solver
            solv = Solver();
            % Resolver el Sudoku y obtener el tablero resuelto
            tablero = solv.resolverSudoku(tab.getTablero());
            % Crear un nuevo objeto Tablero con el tablero resuelto
            tab = Tablero(tablero);
            % Dibujar el tablero resuelto
            obj.dibujarSudoku(tablero, ax);

            
        end
    end
end

  
