# Informe 
## Herramientas Flex y Bison

---

### Información General

- Asignatura: Lenguajes de Programación  
- Tema: Introducción a Flex y Bison  
- Capítulo: 1  
- Lenguaje utilizado: C  
- Entorno de trabajo: Cygwin  
- Herramientas utilizadas:
  - Flex
  - Bison
  - GCC

---

## Objetivo

Implementar y ejecutar los ejemplos del Capítulo 1 del libro Flex & Bison, con el fin de comprender el funcionamiento básico del análisis léxico y sintáctico mediante el uso de herramientas generadoras de analizadores.

---

## Example 1-1 – Word Count Scanner

### Archivo:
fb1-1.l

### Descripción:

Este ejemplo implementa un analizador léxico similar al comando wc de Unix, el cual permite contar:

- Número de líneas  
- Número de palabras  
- Número de caracteres  

El programa utiliza expresiones regulares para identificar palabras, saltos de línea y caracteres individuales.

### Compilación:

```bash
flex -o fb1-1.c fb1-1.l
gcc -o fb1-1 fb1-1.c -lfl
```
<img width="550" height="321" alt="Captura de pantalla 2026-02-18 203407" src="https://github.com/user-attachments/assets/4cf8579f-4802-4ed0-a624-68640824218b" />

## Example 1-2 – English to American Translator
Archivo:

fb1-2.l

### Descripción:

Este ejemplo implementa un analizador léxico que reemplaza ciertas palabras escritas en inglés británico por su equivalente en inglés americano mediante reglas definidas en el scanner.

### Compilación:

```bash
flex -o fb1-2.c fb1-2.l
gcc -o fb1-2 fb1-2.c -lfl
```
<img width="424" height="243" alt="Captura de pantalla 2026-02-18 221202" src="https://github.com/user-attachments/assets/819cd3c2-e585-4303-9b43-20209bebd398" />

## Example 1-3 – Simple Calculator Token Scanner
Archivo:

fb1-3.l

### Descripción:

Este ejemplo reconoce tokens utilizados en operaciones matemáticas como:

- Suma

- Resta

- Multiplicación

- División

- Valor absoluto

- Números enteros

Cada token reconocido es impreso en la salida estándar.

### Compilación:

```bash
flex -o fb1-3.c fb1-3.l
gcc -o fb1-3 fb1-3.c -lfl
```

<img width="359" height="332" alt="Captura de pantalla 2026-02-18 222026" src="https://github.com/user-attachments/assets/3a8ab236-0cf9-474e-ba9a-745e60b3fdf3" />

## Example 1-4 – Calculator Scanner with Tokens
Archivo:

fb1-4.l

### Descripción:

Este scanner reconoce tokens asociados a operaciones matemáticas y asigna valores enteros mediante el uso de la variable yylval, retornando los tokens al parser para su posterior análisis.

### Compilación:

```bash
flex -o fb1-4.c fb1-4.l
gcc -o fb1-4 fb1-4.c -lfl
```

<img width="261" height="234" alt="Captura de pantalla 2026-02-18 222731" src="https://github.com/user-attachments/assets/053afb2e-ffac-4726-a697-61e0b49e2d9c" />

## Example 1-5 – Simple Calculator with Bison
Archivos:

fb1-5.l
fb1-5.y

### Descripción:

Este ejemplo implementa una calculadora simple mediante el uso conjunto de Flex (scanner léxico) y Bison (parser sintáctico). El parser permite evaluar expresiones matemáticas y calcular su resultado.

### Compilación:

```bash
bison -d -o fb1-5.tab.c fb1-5.y
flex -o fb1-5.lex.c fb1-5.l
gcc -o fb1-5 fb1-5.tab.c fb1-5.lex.c -lfl
```
<img width="561" height="327" alt="Captura de pantalla 2026-02-18 223430" src="https://github.com/user-attachments/assets/571cfaed-0a49-4ef9-a1b8-77fe5844b1e5" />
<img width="315" height="116" alt="Captura de pantalla 2026-02-18 224040" src="https://github.com/user-attachments/assets/7493c7a6-57a5-4617-a169-dc5d0248e7cd" />



