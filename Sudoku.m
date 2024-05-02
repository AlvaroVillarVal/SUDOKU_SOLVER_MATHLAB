function Sudoku()
%Este es el programa de Sudoku desarrollado por Álvaro Villar.  
%Este consiste en un programa simple que se ejecuta desde el archivo Sudoku, estos archivos tienes que permanecer en la carpeta en la que viene para funcionar.   
%Este programa te mostrara una rejilla de celdas las cuales se pueden rellenar con los numeros de un sudoku sin solucionar. 
% Una vez introducidos, se pueden hacer dos cosas:  
%-Resolverlo, con el boton de resolver, se te mostrara directamente el sudoku resuelto
%-Guardar el enunciado del sudoku e intentar resolverlo tu mismo, en caso de necesitarlo,
%   se puede pulsar el boton de resolver para que la aplicación lo resuelva. esta función de 
%   resolución tambien se puede usar como ayuda, ya que si se pulsa el boton de resolver , se puede escoger una celda
%   en la que meter el numero que contiene en el sudoku resuelto, devolviendote al estado incial previo a la resolución 
%   pero con este nuevo numero añadido, permitendote que sigas reslviendo el sudoku.

    % Inicializa un tablero de Sudoku vacío de 9x9 donde los ceros representan celdas vacías.
    tablero = [
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0
    ];

    % Crea una instancia de la interfaz de usuario.
    ui = UI();

    % Configura la ventana principal de la aplicación.
    f = figure('Name', 'Sudoku', 'NumberTitle', 'off', 'MenuBar', 'none', 'Resize', 'off', 'Position', [500, 200, 450, 450]);

    % Crea un contexto gráfico para el tablero dentro de la ventana.
    ax = axes('Parent', f, 'Units', 'pixels', 'Position', [50, 50, 350, 350]);

    % Crea un objeto Tablero con el tablero inicial.
    tab = Tablero(tablero);

    % Dibuja el tablero de Sudoku en la interfaz gráfica.
    ui.dibujarSudoku(tab.getTablero(), ax);

    % Asigna una función callback para manejar los clics en las celdas del tablero.
    set(f, 'WindowButtonDownFcn', {@ui.celdaClick, tab, ax});

    % Añade un botón para resolver el Sudoku y asigna su función callback.
    uicontrol('Style', 'pushbutton', 'String', 'Resolver', 'Position', [350 0 100 25], 'Callback', @(src, evnt) ui.botonresolver(src, evnt, ax, tab));

    % Añade un botón para guardar el estado actual del tablero y asigna su función callback.
    uicontrol('Style', 'pushbutton', 'String', 'Guardar', 'Position', [250 0 100 25], 'Callback', @(src, evnt) tab.guardartablero(src, evnt, tab));
    % Añade un botón para resetear la partida
    uicontrol('Style', 'pushbutton', 'String', 'Reset', 'Position', [150 0 100 25], 'Callback', @(src, evnt)reset(src,evnt,f));
end
%Añadimos una función para que cuando haya que volver a empezar no haga
%falta cerrar el programa
function reset(~, ~,f)
%Función para resetear la partida
%Entrada:
%   -f=pantalla de la partida a cerrar
close(f);%cierra la pantalla actual
Sudoku();%Comienza de nuevo
end
