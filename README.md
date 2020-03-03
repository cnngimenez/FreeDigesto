# FreeDigesto
FreeDigesto es una versión Web y libre del digesto jurídico. 

Fue diseñado para el Consejo Deliberante de la ciudad de Allen. Aunque se espera que se utilice para otras ciudades u entidades.

# Instalación
Se recomienda utilizar [rvm](https://rvm.io/) para gestionar la versiones de Ruby y el conjunto de gemas (gemset). Cada uno de los comandos tomará su tiempo y pueden resultar muchas advertencias (*warnings*). Léa detenidamente cada salida. 

## Ambiente Ruby 
Ejecutar las siguientes líneas por única vez:

```fish
curl -sSL https://get.rvm.io | bash -s stable
rvm install 2.7.0
rvm use 2.7.0
rvm gemset create freedigesto
```

1. Instalar rvm (considere ver las instrucciones en la página de rvm).
2. Instale Ruby 2.7.0 (Rails 5.2 funciona con Ruby 2.2.2 o posterior).
3. Activar el uso de Ruby 2.7.0.
4. Crear una gemset denominada "freedigesto". Aquí se instalarán todas las gemas.

Cada vez que quiera utilizar FreeDigesto:

```fish
rvm use 2.7.0@freedigesto
```

1. Active el ambiente con rvm junto con la gemset freedigesto.

## Instalar freedigesto.
El siguiente comando instalará FreeDigesto. Ejecutelos una única vez.

```fish
git clone https://github.com/cnngimenez/FreeDigesto.git
cd FreeDigesto
rvm use 2.7.0@freedigesto
gem install bundler
bundle install
edit config/database.yml # use el editor de texto que usted desee
rake db:migrate
rails server
```

1. Clonar el repositorio. Puede optar por una de estas dos opciones:
  1. `git clone https://bitbucket.org/cnngimenez/freedigesto.git` 
  2. `git clone https://github.com/cnngimenez/FreeDigesto.git`
2. Entrar al directorio.
3. Activar Ruby 2.7.0 y la gemset freedigesto con rvm.
4. Instalar las bundler.
5. Instalar las gemas con bundler.
6. Configurar la BD (véase más abajo).
7. Crear la BD y ejecutar las migraciones.
8. Ejecutar el servidor Web.

Al ejecutar el servidor Web, quedará disponible el sistema en http://localhost:3000 o http://127.0.0.1:3000. El nombre de usuario por defecto es `root` y la clave `root`.

## Ejecutar servidor
Cada vez que quiera activar el servidor FreeDigesto ejecute:

```fish
cd FreeDigesto
rvm use 2.7.0@freedigesto
rails server
```

1. Dirígase a la carpeta FreeDigesto donde realizó el clon.
2. Activar el ambiente si no se realizó automáticamente. 
3. Inicie el servidor Web. 

Recuerde activar el SGBD (MySQL, MariaDB o PosgreSQL) previo a iniciar Rails.

## Configurar el SGBD
Puede utilizar los siguientes Sistema Gestor de Bases de Datos (SGBD): MySQL, MariaDB, SQLite y PostgreSQL. Se recomienda utilizar SQLite en un ambiente de testeo o desarrollo.

La configuración de Rails se realiza sobre el archivo de texto `config/database.yml`. En la guía de configuración de Ruby on Rails, en la sección "[Configuring a Database](https://guides.rubyonrails.org/v5.2/configuring.html#configuring-a-database)" se puede encontrar más información y ejemplos.

# Modo Producción / Deployment
Para la producción, se recomienda utilizar el ambiente productivo de Rails y cambiar el servidor Web por uno más potente. Optar por un Proxy inverso (*reverse proxy* en inglés) es lo ideal para gestionar el balance de carga.

El ambiente productivo se puede activar al momento de iniciar el servidor de la siguiente manera: `rails server -e production`. También se puede utilizar la variable de ambiente `ENV["RAILS_ENV"]` y asignarle el valor `production`.

Véase la sección [Deploy to a Subdirectory](https://guides.rubyonrails.org/v5.2/configuring.html#deploy-to-a-subdirectory-relative-url-root) en la guía de Ruby on Rails para más información.

# Licencia
![GPLv3](https://www.gnu.org/graphics/gplv3-with-text-136x68.png)

FreeDigesto se encuentra bajo la Licencia General Public License versión 3 (GPLv3).

Para más información, consulte la licencia en el archivo COPYING.txt o visite su sitio Web en https://www.gnu.org/licenses/gpl-3.0.html


Copyright 2010 Christian Gimenez. This work is under the GPL version 3.
