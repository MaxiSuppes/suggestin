# README

### Precondiciones: 
- Tener instalado ruby utilizando rbenv ([Tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-18-04))
- Tener instalado postgres y configurado un usuario con rol de superuser ([Tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04))

### Clonar el repositorio
``` git clone https://github.com/MaxiSuppes/suggestin.git```

### Instalar dependencias
En la carpeta root del proyecto ejectutar los siguientes comandos

``` gem install bundler ``` Para manejar las gemas

``` bundle install ``` Instala todas las dependencias

### Configurar la base de datos
- Crear en la carpeta root del proyecto un archivo llamado ".env" y poner dentro el contenido del archivo ".env.example" 
reemplazando en él los valores de POSTGRES_USER y POSTGRES_PASSWORD de acuerdo a lo configurado al instalar postgres

- Correr los siguientes comandos:

``` rake db:setup ``` Para crear las bases de datos de test y desarrollo
``` rake db:migrate  ``` Para migrar la base de datos con el schema inicial


### Levantar la web
- Ejecutar el comando ``` rails server  ``` en la carpeta root del proyecto.
