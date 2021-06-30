# Logging en *Calclogic*

**Calclogic** produce una gran cantidad de *logs* en los ambientes en la nube,
que son de gran utilidad para mantener la seguridad de la aplicación. Dichos 
*logs*, deben ser analizados para identificar comportamientos anómalos en la 
aplicación. Para ello, se ha definido el siguiente esquema de manipulación de
*logs*:

- Los *logs* son capturados por un *middleware* dentro de la aplicación.
- Son enviados a un servidor externo de *logs*
- Los *logs* son analizados para la identificación de patrones anómalos.

## Middleware de Peticiones

Ya que *Calclogic* es una aplicación web, cualquier interacción con ella se 
realiza a través de peticiones HTTP. Fue configurado un *middleware* que 
intercepta todas las peticiones que se realicen a la aplicación y extrae los 
siguientes datos:

* Dirección IP de la petición
* Puerto de la petición
* Método HTTP utilizado
* URI solicitada en la aplicación
* Estado de la respuesta HTTP (*HTTP Status*)

Este middleware puede ser consultado en `calclogic/controller/RequestInterceptor.java`.
Es importante recalcar que se usa el método `afterCompletion` para realizar la
captura, lo que quiere decir que solo se crearán los *logs* una vez que haya
sido completamente procesada la petición.

## Automatización de la Extracción de *Logs*

Para automatizar la captura de *logs* en el servidor disponibilizado para ello, 
se creó un servicio que se inicia automáticamente al encender el computador. 
Dicho servicio ejecuta constantemente un *Servidor de Sockets de log4j*, el 
cual escucha hasta que se le sean enviado *logs* con el formato indicado.

### Configuración de *log4j*

La configuración de la librería de *logging* se encuentra en el archivo 
`src/main/resources/log4j.properties`. Este archivo es de particular importancia
porque en el se encuentra la dirección y puerto del servidor de sockets que 
recibirá los *logs*.

La configuración que se encuentra en ese archivo realiza las siguientes tareas:
* Envía los *logs* a la salida estándar (*stout*)
* Guarda los *logs* en el servidor de *tomcat* donde se esté ejecutando la 
  aplicación.
* Envía los *logs* al *Servidor de Sockets*. 

### Servidor de Sockets

Para la creación del *Servidor de Sockets* se utilizó la utilidad de *log4j* 
para captura de *logs* via socket. Para utilizarla, debemos tener la librería de
a nuestra disposición. Dicha librería se encuentra disponible en este repositorio
en `/logging/log4j-1.2.17.jar`.

Para ejecutar el *Servidor de Sockets* debemos ejecutar:
```bash
$> java <PATH_TO_JAR> org.apache.log4j.net.SimpleSocketServer <PORT> [PATH_TO_CONFIG]
```

#### Archivo de Configuración

El *Servidor de Sockets* recibe una cantidad de parámetros que permiten 
configurar su comportamiento, a través de un archivo de configuración.

El archivo de configuración utilizado en el servidor de *logs* puede ser 
consultado en `/logging/log4j-server.properties`.

#### Automatización del Servidor de Sockets

Para automatizar el funcionamiento del servidor de sockets, fue creado un 
servicio de Linux creando un archivo de configuración en la carpeta 
`/etc/systemd/system/` llamado `calclogiclogs.service`, el cuál también se 
encuentra a modo de ejemplo en `/logging/calclogiclogs.service`.

Una vez creado este archivo, es necesario inciar el servicio con el comando 
`systemctl start calclogiclogs` con permisos de administrador.

Adicionalmente, si se desea consultar el estado del servicio podemos ejecutar
el siguiente comando `systemctl status calclogiclogs`.

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
