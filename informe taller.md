## Solucion ejercicios de capitulo 1

## Objetivo

Resolver los ejercicios propuestos en el Capítulo 1 del libro Flex & Bison, con el fin de aplicar modificaciones al analizador léxico y sintáctico implementado en el Example 1-5, mejorando sus funcionalidades y evaluando su comportamiento.

---

## Ejercicio 1

**¿La calculadora acepta una línea que contiene solo un comentario? Si no, arréglalo. ¿Scanner o Parser?**

Inicialmente, la calculadora no aceptaba una línea que contuviera únicamente un comentario, ya que el scanner no tenía una regla definida para reconocer este tipo de entrada, lo que ocasionaba que el parser recibiera tokens no válidos y produjera un error de sintaxis.

La solución se implementó en el scanner (archivo `.l`), agregando una regla que permite ignorar comentarios de una sola línea y retornar el token EOL (End Of Line), permitiendo que el parser interprete correctamente la línea como válida.

### Modificación realizada en el scanner:

``` 
lex
"//".*      { return EOL; }
```

Adicionalmente, se modificó el parser para aceptar líneas vacías o que contengan únicamente comentarios:

``` 
| calclist EOL       { }
```

De esta forma, la calculadora ahora acepta líneas con comentarios sin generar errores.

<img width="461" height="246" alt="Captura de pantalla 2026-02-18 231645" src="https://github.com/user-attachments/assets/169e4dd7-951d-4c20-b527-a8f4033efe3e" />

---

<img width="344" height="94" alt="Captura de pantalla 2026-02-18 232933 - copia" src="https://github.com/user-attachments/assets/0b11be1e-b6e3-4ec9-848b-e5bd3ac1dd66" />

---

<img width="455" height="126" alt="Captura de pantalla 2026-02-18 233045" src="https://github.com/user-attachments/assets/cbf50dcc-601a-427c-bac5-6bea80f4802e" />

---


## Ejercicio 2

Modificar la calculadora para aceptar números hexadecimales y decimales, convirtiéndolos con la función strtol.

Se modificó el scanner para aceptar números en formato hexadecimal mediante el uso de la expresión regular correspondiente. Para la conversión de los valores, se utilizó la función strtol() de la biblioteca estándar de C.

### Modificaciones realizadas:

``` 
 0[xX][0-9a-fA-F]+  { yylval = (int)strtol(yytext, NULL, 0); return NUMBER; }
[0-9]+             { yylval = (int)strtol(yytext, NULL, 10); return NUMBER; }

```
``` 
printf("= %d (0x%X)\n", $2, (unsigned)$2);

```
``` 
echo "0xA+5" | ./calc-ej2

```
<img width="537" height="196" alt="Captura de pantalla 2026-02-18 234655" src="https://github.com/user-attachments/assets/4c562340-449d-49eb-bb59-a6dcec9e5573" />

---

<img width="306" height="172" alt="Captura de pantalla 2026-02-19 000155" src="https://github.com/user-attachments/assets/458b104b-038e-4b81-970b-ea8b7d1f203b" />

---

## Ejercicio 3

Agregar operaciones AND y OR bit a bit. ¿Qué pasa si se utiliza el símbolo | como OR si ya se utiliza para ABS?

Se agregaron dos nuevos operadores lógicos: AND y OR, representados por los símbolos & y la palabra reservada OR.

### Modificaciones realizadas en el scanner:

``` 
"&"     { return AND; }
"OR"    { return OR; }
```

### Modificaciones realizadas en el parser:

``` 
%token AND OR
```

### Se añadieron las siguientes reglas a la gramática:

``` 
| exp AND factor     { $$ = $1 & $3; }
| exp OR  factor     { $$ = $1 | $3; }

```
El uso del símbolo | como operador OR genera ambigüedad, ya que este símbolo ya se emplea como operador unario para el cálculo del valor absoluto. Esta doble funcionalidad puede ocasionar conflictos en el análisis sintáctico, como errores de tipo shift/reduce, debido a que el parser no puede determinar si el operador se utiliza de forma unaria o binaria.

Por esta razón, se optó por utilizar la palabra reservada OR para representar la operación OR bit a bit.

<img width="214" height="168" alt="Captura de pantalla 2026-02-19 005043" src="https://github.com/user-attachments/assets/4ca77326-00c5-43e0-90e2-54beeab4c82f" />

---

<img width="550" height="276" alt="Captura de pantalla 2026-02-19 010427" src="https://github.com/user-attachments/assets/e1648080-dbff-4122-b661-cd856eeb08e0" />

---

<img width="382" height="109" alt="Captura de pantalla 2026-02-19 010855" src="https://github.com/user-attachments/assets/3928f134-7e4f-4c53-8766-b17cdb88299a" />

---

<img width="278" height="107" alt="Captura de pantalla 2026-02-19 010730" src="https://github.com/user-attachments/assets/349a92e8-5748-4dc2-b76b-6dad263a6471" />

---

## Ejercicio 4

### Enunciado:
¿El scanner escrito a mano del Example 1-4 reconoce exactamente los mismos tokens que la versión con flex?

### Desarrollo:

No necesariamente. Aunque ambos scanners pueden reconocer los mismos tokens en casos simples, la versión generada con Flex utiliza reglas formales para seleccionar coincidencias, como:

- Selección de la coincidencia más larga posible.
- En caso de empate, selección de la primera regla definida.

Por otro lado, un scanner implementado manualmente depende de la lógica programada por el desarrollador, lo que puede ocasionar diferencias en el reconocimiento de tokens, especialmente en casos límite como caracteres inesperados o combinaciones no contempladas.

---

## Ejercicio 5

### Enunciado:
¿Puedes pensar en lenguajes para los que Flex no sería una buena herramienta para escribir el scanner?

### Desarrollo:

Flex no es la mejor opción en lenguajes donde el análisis léxico depende fuertemente del contexto o de la indentación. Un ejemplo claro es el lenguaje Python, en el cual la indentación determina la estructura del programa, generando tokens como INDENT y DEDENT.

Asimismo, lenguajes que utilizan interpolación de cadenas o estructuras anidadas complejas pueden requerir lógica adicional que no puede ser expresada fácilmente mediante expresiones regulares.

## Ejercicio 6

### Enunciado:

Reescribir el programa Word Count en C. Ejecutar ambos programas con archivos grandes y comparar su rendimiento.

### Desarrollo:

Se implementó una versión del programa Word Count utilizando el lenguaje C de forma manual, sin el uso de Flex.

Compilación del programa en C:

```
gcc -O2 -o wc_c wc_c.c
```
Se generó un archivo de prueba de gran tamaño utilizando el siguiente comando:

```
yes "hola mundo esto es una linea de prueba" | head -n 200000 > grande.txt

```

Posteriormente, se midió el tiempo de ejecución de ambas versiones:

Versión Flex:

```
time ../cap1/fb1-1 < grande.txt

```
Versión en C:

```
time ./wc_c < grande.txt

```

** Se observó que la versión implementada directamente en C presenta un mejor rendimiento en comparación con la versión generada con Flex, debido a que el código escrito manualmente no incluye la sobrecarga asociada al motor de análisis léxico.

<img width="540" height="338" alt="Captura de pantalla 2026-02-19 011736" src="https://github.com/user-attachments/assets/94c8b2b5-30c3-4347-9d72-7c42916de0bd" />

---

## Conclusión

El desarrollo de los ejercicios permitió comprender el funcionamiento del análisis léxico y sintáctico mediante el uso de herramientas como Flex y Bison. Asimismo, se evidenció la facilidad que estas herramientas ofrecen para la generación automática de analizadores, aunque en ciertos casos el desarrollo manual puede ofrecer ventajas en términos de rendimiento.

