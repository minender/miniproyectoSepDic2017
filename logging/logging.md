# Logging en *Calclogic*

**Calclogic** produce una gran cantidad de *logs* en los ambientes en la nube,
que son de gran utilidad para mantener la seguridad de la aplicación.
Dichos *logs*, son constantemente extraídos desde Heroku a través de su CLI. 

## Autenticación

Para poder utilizar correctamente el CLI, es necesario haberse previamente 
autenticado a través del comando `heroku login`, que abrirá una ventana para 
iniciar sesión a través de la aplicación.

## Extracción de *Logs*

Para extraer los *logs*, se usa el comando `heroku logs --app <>`. Explicar
que solo estamos usando los logs de un tipo y por qué.

## Automatización de la Extracción de *Logs*

Para automatizar la tarea descrita en la sección anterior, se creó un servicio
en el servidor encargado de la extracción de los logs, que se inicia 
automáticamente al encender el computador. Dicho servicio ejecuta la extración
de los *logs* y redirecciona su salida hacia un archivo de texto.

El script ejecutado por el servicio se encuentra en esta carpeta y es llamado 
`nombre del archivo`.

### Creación de un servicio en Linux



## Configuración de *Logs* de Hibernate

Debido al gran tráfico de *logs* generado por *Hibernate* (el ORM del proyecto),
fue necesario desabilitar la impresión de las consultas SQL que se realizaban
en la base de datos. Sin embargo, dichas consutas pueden ser útiles para el 
desarrollo de la aplicación, por lo que se definió la configuración de estas a 
través de una variable de entorno llamada `JDBC_HIBERNATE_SQL_LOG`. Esta 
variable debe estar definida en todas las cuentas de *Heroku* donde sea desplegada
la aplicación con el valor `false` (para evitar la impresión de las consultas),
y con el valor `true` en el servidor de *Tomcat* que tenga cada uno de los 
desarrolladores localmente instalado en su computadora (para que se impriman
las consultas).

## Desarrolladores
* Manuel Faria *(15-10463)*
* Juan Oropeza *(15-11041)*
