# Compilación de Gramáticas con ANTLR V4

Para generar cambios sobre una gramática escrita con ANTLR V4, es necesario 
modificar su archivo `.g4` el cual contiene las producciones de la misma.

Una vez realizados los cambios pertinentes sobre la gramática, es necesario 
compilarla de manera que se creen los archivos que son autogenerados por la 
herramienta. Para ello, debemos situarnos en la carpeta `./src/main/java` (es
decir, en la carpeta donde se contienen todos los paquetes de *Java*) y ejecutar
el siguiente comando:

```java
$ java -cp <path_to_antlr4_jar>:. org.antlr.v4.Tool <path_to_g4_file>
```

El ejecutable `.jar` de *ANTLR4* se encuentra en la carpeta del parser, y es 
llamado `antlr-4.8-complete.jar`. En el comando anterior debe ajustar la 
referencia correcta a su ubicación o tener la herramienta instalada localmente
con la versión especificada (4.8).

Una vez ejecutado este comando, se modificarán los archivos necesarios para el 
funcionamiento de la gramática. 

## Consideraciones

* Debe tomar en cuenta que la modificación de la gramática en su estado actual
puede provocar fallas en los métodos sobre los diferentes nodos del árbol 
sintáctico que se crea.

## Desarrolladores
* Manuel Faria *(15-10463)*
* Juan Oropeza *(15-11041)*
