## Prerequisitios

### Codecov

Para el análisis de cobertura de las pruebas, es necesario que se tenga acceso 
a la cuenta que es dueña del repositorio, ya que esta está a su vez asociada a 
la cuenta de [codecov](https://about.codecov.io/) donde se publican los resultados.

Si se desea crear una nueva cuenta, es necesario crear una cuenta en la 
[página de codecov](https://about.codecov.io/) y vincular el proyecto con la página.

Una vez creado el proyecto en codecov, se generará un token. Dicho token, debe 
ser agregado en el repositorio como un *secret*. Para más información sobre como
agregar un *secret*, visita la [documentación de secrets](https://docs.github.com/en/actions/reference/encrypted-secrets). 

En el *pipeline* se ejecuta un paso en el que esto se realiza automáticamente y 
será explicado en la siguiente sección.

Es importante que el *secret* posea el mismo nombre que el referido en el archivo
del *pipeline* (`CODECOV_TOKEN` en el paso "Code Coverage on Codecov").

### Heroku

Para realizar el despliegue de la aplicación en Heroku desde GitHub Actions, es
necesario fornecer los permisos necesarios. Para esto, debemos buscar el API Key
en Heroku > Confuguración > API Key. Este valor debe ser agregado como un *secret*
en el repositorio.

Es importante que el *secret* posea el mismo nombre que el referido en el archivo
del *pipeline* (`HEROKU_API_TOKEN_DEVELOPMENT` en el paso "Publish Project on Heroku").

## Pasos de Despliegue Continuo

Para el despliegue de la aplicación con el uso de **GitHub Actions** se creó un
*pipeline* the ejecución, especificado en el archivo `may-jul-2021.yml`. Dicho
*pipeline* consta de las siguientes fases:

#### 1. Checkout

Fase necesaria para la ejecución de cualquier *pipeline* de GitHub Actions, genera
la configuración incial para su ejecución.

#### 2. Set up JDK 8

Ejecuta la accion `setup-java@v2`, que se encarga de instalar la versión de la 
máquina virtual de Java necesaria para la construcción del proyecto (OpenJDK 8).

#### 3. Clean for Maven

Ejecuta la limpieza del entorno de Maven para dejar el ambiente listo para la 
contrucción del proyecto.

#### 4. Build with Maven

Genera el archivo ejecutable `.war` que será desplegado en el servidor. 
Adicionalmente se ejecutan las pruebas del compilable.

#### 5. Code Coverage on Codecov

Se vuelven a ejecutar los tests para calcular que porcentaje del código se encuentra
contemplado por las pruebas. Estos resultados son publicados en la [página de codecov](https://about.codecov.io/), a través del token del proyecto (explicado en las próximas secciones).

#### 6. Publish Project on Heroku

Una vez aprobadas todas las pruebas y la compilación del archivo, este se envía
a Heroku, donde posteriormente será desplegado. Para efectos de este ejemplo, 
se usa el api key de la cuenta personal de los estudiantes que trabajaron en el
proyecto en el trimestre Mayo-Julio 2021. 

#### 7. Deploy App on Heroku

Una vez que el proyecto fue publicado en Heroku, se hace el despligue para que 
pueda ser accedido a través de su URL. Para el efecto de este ejemplo, se usa el
[url del Miniproyecto de Abr-Jul 2021](https://miniproyecto-abr-jul-2021.herokuapp.com/).

## Configuración del *Pipeline*

Para configurar el *pipeline* en otra rama o repositorio, basta con utilizar el 
archivo `may-jul-2021.yml` que se encuentra en la misma carpeta que este archivo
y realizar un push al repositorio de GitHub. 

Es importante que se configure la rama desde la cual se desea hacer el despliegue.
En nuestro ejemplo, esta rama será `may-jul-2021` (Línea 6). Del mismo modo,
se recomienda cambiar el nombre del *pipeline* (Línea 1).

## Medallas de Estado



## Desarrolladores

* Manuel Faria (15-10463)
* Juan Oropeza (15-11041)
