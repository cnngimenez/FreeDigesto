# -*- coding: utf-8 -*-

# norma.rb
# Copyright (C) 2010  Gimenez, Christian N.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Jueves 07 De Octubre Del 2010

class Norma < ApplicationRecord
  # Privilegios:
  PuedeCrear = "Crear Normas"
  PuedeEditar = "Editar Normas"
  PuedeEliminar = "Eliminar Normas"
  PuedeConsultar = "Consultar Normas"

  # Tipos de fecha para la búsqueda de normas por medio de fechas.
  Tipo_fecha_sancion = "fecha_sancion"
  Tipo_fecha_promulgacion = "fecha_promulgacion"
  Tipo_fecha_publicacion = "fecha_publicacion"

  #Mirar el modelo DIA y SQL
  #La norma ya no posee el atributo estado desde las versiones 1.4 en adelante...
  # belongs_to :estado
  belongs_to :tipo_norma
  belongs_to :lugar_publicacion

  has_many :posee_descriptors
  has_many :posee_desc_parts
  has_many :cambio_estados
  has_many :relaciona_con_normas

  
  #Valida la presencia de los campos número de norma, sumario y texto.
  #¡numero de norma y el tipo son claves primarias!
  validates_presence_of(:numero, :message => "¡Debe escribir un número!")
  validates_presence_of(:tipo_norma_id,
                        :message => "¡Debe escojer un tipo de norma!")

  validates_presence_of(:sumario,
                        :message => "¡Debe escribir un sumario!")
  #No necesariamente puede tener un texto.
  #validates_presence_of(:texto, :message => "¡Debe escribir un texto!")


  #La norma ya no posee el atributo estado desde las versiones 1.4 en adelante...
  #validates_presence_of(:estado, :message => "¡Debe escojer un estado!")
  validates_presence_of(:lugar_publicacion,
                        :message => "¡Debe escojer un lugar de publicacion!")

  # ¿es necesario las validaciones estas?
  # NOP... Pues se utiliza un tipo de listado para buscarlos...
  # Igualmente sería útil para evitar un POST inadecuado y hacer que la
  # base de datos
  # no posea valores inadecuados.
  # ¡Lo útil sería armar la base de datos como corresponde! Pero bueno :-S
  #
  # Valida que el campo Tipo_norma sea una entrada de la tabla "tipo_norma"
  # validates_inclusion_of(:tipo_norma,
  #  :in => TipoNorma.all,
  #  :message => "¡Tipo de norma inválido!")

  # Valida que el campo Lugar_publicacion sea una entrada de la tabla
  # "lugar_publicacion".
  # validates_inclusion_of(:lugar_publicacion,
  #  :in => LugarPublicacion.all
  #  :message => "¡El lugar de la publicación no es válido!")


  # Valida que el campo Estado sea una entrada de la tabla "estados"
  # validates_inclusion_of(:estado,
  #   :in => Estado.all,
  #   :message => "¡El estado no es válido!")

  # Valida que el número de norma sea único y no se repita en la tabla
  # No poner validates_uniqueness_of(:numero, :tipo_norma_id, ...
  # pues verifica la uniquidad en los dos:
  # Ej.:
  # Norma1 Tipo1
  # Norma2 Tipo1 -> ¡Error! ¡Porque "Tipo1" no es único!
  validates_uniqueness_of(:numero, :scope => [:tipo_norma_id],
                          :message => "¡Ese número de norma ya existe!")


    ##
  # Asigna un estado a la norma.
  #
  # Recordar que el estado actual de la norma es el último estado aplicado.
  # Aquí hay que crear varios objetos:
  #   - Cambio_estado con:
  #     - fecha_de_cambio = la fecha de hoy
  #     - norma = /norma/
  #     - comentario = /comentario/
  #     - fecha_de_creacion = la fecha de hoy
  #     - causa_de_cambio = /causa_cambio_estado/
  #     - estado = estado_id.
  #   - Cambio_aplicado con:
  #     - fecha_aplicado = la fecha de hoy
  #     - cambio_estado = el creado en el paso anterior
  #     - comentario = /comentario/
  #
  # Devuelve el Cambio_aplicado
  #
  # Comentarios: No chequea si ese estado_id existe.
  #
  # Si la causa_cambio_estado es nil, entonces se utilizara la causa de cambio
  # "Aplicada por el usuario"(CausaCambioEstado::AplicadoPorUsuario)
  #
  def Norma::asignar_estado(estado_id, comentario, norma,
                            causa_cambio_estado = nil)
    # Crear el cambio estado
    ce = CambioEstado.new
    ahora = Time.now
    fecha_ahora = ahora.strftime '%Y-%m-%d'
    ce.fecha_cambio = fecha_ahora
    ce.norma_id = norma.id
    ce.comentario = comentario
    ce.fecha_creacion = fecha_ahora

    cc = causa_cambio_estado
    if cc.nil?
      # no ingreso una causa de estado! agregar la "aplicada por el usuario"
      cc = CausaCambioEstado.where(['nombre = ?', CausaCambioEstado::AplicadoPorUsuario]).first
      if cc.nil?
        # No existe esa causa de cambio! crearla...
        cc = CausaCambioEstado.crear_aplicado_por_usuario
      end
    end
    ce.causa_cambio_estado_id = cc.id
    ce.estado_id = estado_id

    unless ce.save validate: true
      # El Cambio de Estado no se pudo incorporar a la Base... salir!
      return nil
    end

    ca = CambioAplicado.new
    ca.fecha_aplicado = ahora
    ca.cambio_estado_id = ce.id
    ca.comentario = comentario
    ca.save validate: true
    ca
  end

  # Devuelve el estado actual de la norma.
  #
  def Norma::obtener_estado_actual(norma)
    CambioEstado.obtener_estado_actual(norma)
  end

  # Devuelve todos los cambios aplicados (CambioAplicado) por los
  # que pasó la norma |norma|.
  #
  def Norma::obtener_cambios_estados_aplicados(norma)
    CambioAplicado.obtener_cambios_aplicados(
      norma,
      CambioAplicado::PorFechaCambio,
      CambioAplicado::Descendente)
  end

  # Devuelve todos los cambios de estados sean aplicados o no.
  #
  #
  def Norma::obtener_cambios_estados(norma)
    CambioEstado.obtener_cambio_estados(
      norma,
      CambioEstado::PorFechaCambio,
      CambioEstado::Descendente)
  end

  # Devuelve un hash con los cambios de estados aplicados.
  # Como clave usa los id de los cambios de estados.
  #
  # Útil para relacionar los cambios de estados y sus cambios aplicados.
  #
  def Norma::obtener_hash_cambios_aplicados(norma)
    lst_cambios_aplicados = self.obtener_cambios_estados_aplicados(norma)
    h = Hash.new
    lst_cambios_aplicados.each do |ca|
      h[ca.cambio_estado.id] = ca
    end

    return h
  end

  # Devuelve el estado actual.
  # En caso de error devuelve nil.
  #
  def obtener_estado_actual()
    ce =  CambioEstado.obtener_estado_actual(self)
    if ce.nil?
      return nil;
    else
      return ce.estado
    end
  end

  # Buscar una norma por numero y tipo de norma
  #
  #   [+numero+]      String con el numero de norma
  #   [+tipo_norma+]  Un Tipo_Norma
  #
  def Norma::buscar_por_num(numero, tipo_norma)
    Norma.where(['numero = ? AND tipo_norma_id = ?', numero, tipo_norma.id.to_s]).first
  end

  # Buscar una norma por numero y tipo de norma
  #
  #   [+numero+]        String con el numero de norma
  #   [+tipo_norma_id+] El id del tipo de norma
  #
  def Norma::buscar_por_num_ids(numero, tipo_norma_id)
    Norma.where(['numero = ? AND tipo_norma_id = ?', numero, tipo_norma_id.to_s]).first
  end

  #  Agrega las "otras condiciones" que son:
  #      * Limitar la búsqueda por el tipo de norma que tenga.
  #      * Limitar la búsqueda por un estado en particular que tenga la norma.
  #      * Limitar la búsqueda sólo a las normas particulares, generales o ambas.
  #
  #  Los parámetros son:
  #     [+condiciones+]     Que es el string de la condición inicial.
  #     [+otras_opciones+]  Un hash con las opciones a agregar.
  #
  #  +condiciones+ es un Array de la forma que indica en Norma.find() bajo la
  #  opción +:conditions+.
  #  En otras palabras, aquí tendría la siguiente forma:
  #
  #     [condstring, parametro1, parametro2, parametro3, etc...]
  #
  #  Donde +condstring+ es una condición en SQL.
  #  Obsérvese que +condstring+ puede tener comodines "?" que serán reemplazados
  #  por +parametro1,parametro2,etc.+ según el orden de aparición de los "?".
  #
  #  Ejemplo:
  #     [instr(numero,?) AND id > ?, "/10", 3]
  #
  #  Esto termina generando una condición así:
  #     "instr(numero, "/10") AND id > 3"
  #
  #  +otras_opciones+ es un hash que puede tener las siguientes claves:
  #     [+:estado_id+]      Genera la condición para que limite la búsqueda según
  #                         el estado cuyo id es el valor dado por esta clave.
  #     [+:tipo_norma_id+]  Genera la condición para que limite la búsqueda según
  #                         el tipo de norma cuyo id es dado por el valor de esta
  #                         clave.
  #     [+:general+]        Genera la condición para que limite la búsqueda sólo
  #                         a las normas generales si el valor de esta clave es
  #                         +true+, si es +false+ a las particulares y si es
  #                         +nil+ o no está presente a ambas.
  #
  # Finalmente, *devuelve* un arreglo de la forma de +condiciones+ con las otras
  # condiciones correspondientes a las "otras opciones" agregadas con los
  # parámetros que requiera.
  #
  # Ejemplo:
  #     Norma.agregar_otras_opciones(["instr(texto,?)", "hola"],
  #       {:estado_id => 1, :tipo_norma_id => 2})
  #
  # Devulve:
  #     ["instr(texto,?)  AND (
  #     SELECT cambio_estados.estado_id
  #     FROM cambio_estados, cambio_aplicados
  #     WHERE
  #       cambio_estados.norma_id = normas.id AND
  #       cambio_aplicados.cambio_estado_id = cambio_estados.id
  #     ORDER BY cambio_aplicados.fecha_aplicado DESC
  #     LIMIT 1
  #     ) = ? AND tipo_norma_id = ?","hola", 1, 2]
  #
  # Este formato está listo para usarse con Norma.find():
  # Ejemplo:
  #     cond = Norma.agregar_otras_opciones(
  #       ["instr(texto,?)", "hola"],
  #       {:estado_id => 1, :tipo_norma_id => 2})
  #     Norma.find(:all, :conditions => cond)
  #
  def Norma::agregar_otras_opciones(condiciones, otras_opciones = {})
    condstring = condiciones[0]

    # Para buscar el estado es necesario una consulta mucho más complicada:
    # hace falta agregar en el "WHERE" del SQL:
    # en la sección WHERE:
    # (SELECT cambio_estado.estado_id FROM cambio_estados, cambio_aplicados
    # WHERE
    #   cambio_estado.norma_id = [norma_id] AND
    #   cambio_aplicados.cambio_estado_id = cambio_estados.id
    # ORDER BY cambio_aplicados.fecha_aplicado DESC
    # LIMIT 1) = [estado_id]
    unless otras_opciones[:estado_id].nil?
      #Selecciono un estado.
      condstring = condstring + " AND (
    SELECT cambio_estados.estado_id
    FROM cambio_estados, cambio_aplicados
    WHERE
      cambio_estados.norma_id = normas.id AND
      cambio_aplicados.cambio_estado_id = cambio_estados.id
    ORDER BY cambio_aplicados.fecha_aplicado DESC
    LIMIT 1
    ) = ? "
      condiciones.push(otras_opciones[:estado_id])
    end

    unless otras_opciones[:tipo_norma_id].nil?
      #Seleccionó un tipo de norma en particular.
      condstring = condstring + " AND tipo_norma_id = ?"
      condiciones.push(otras_opciones[:tipo_norma_id])
    end

    unless otras_opciones[:general].nil?
      if otras_opciones[:general]
        #Eligió buscar los que sean generales
        condstring = condstring +  " AND general = true"
      else
        #Eligió buscar los que sean particulares
        condstring = condstring + " AND general = false"
      end
    end

    condiciones[0] = condstring

    return condiciones
  end

  # Devuelve un string con el orden con el que se debe ordenar los resultados
  # de una búsqueda.
  # La salida tiene un formato SQL, ejemplos:
  #   "numero ASC"
  #   "fecha_sancion ASC"
  #
  #   [+orden+] Un Hash que posee uno de los siguientes tipos, y va al
  #     string ASC o DESC.
  #     :numero
  #     :fecha_sancion
  #     :fecha_publicacion
  #     :fecha_promulgacion
  #     :creado
  def Norma::agregar_orden(orden)
    if not orden[:numero].nil?
      ord_string = "normas.numero " + orden[:numero]
    elsif not orden[:fecha_sancion].nil?
      ord_string = "normas.fecha_sancion " + orden[:fecha_sancion]
    elsif not orden[:fecha_promulgacion].nil?
      ord_string = "normas.fecha_promulgacion " + orden[:fecha_promulgacion]
    elsif not orden[:fecha_publicacion].nil?
      ord_string = "normas.fecha_publicacion " + orden[:fecha_publicacion]
    elsif not orden[:creado].nil?
      ord_string = "normas.updated_at " + orden[:creado]
    end

    return ord_string
  end

  # Busco una serie de normas segun un rango de fechas.
  # Tipo de fecha puede ser:
  #   [+Norma::Tipo_fecha_sancion+]
  #     Busca las normas dentro del rango en la fecha de sancion
  #   [+Norma::Tipo_fecha_promulgacion+]
  #     Busca las normas dentro del rango en la fecha de promulgacion
  #   [+Norma::Tipo_fecha_publicacion+]
  #     Busca las normas dentro del rango en la fecha de publicacion
  #
  # Otras opciones es un hash con valores que pueden ser:
  #   [+:estado_id+]      El id del estado con el cual limitar la busqueda.
  #   [+:tipo_norma_id+]  El id del tipo de norma con el cual limitar
  #                       la busqueda.
  #   [+:general+]        True si buscar normas de tipo general solamente,
  #                       false si buscar solo los particulares. Si no esta
  #                       (o es nil) se buscara tanto particulares
  #                       como generales.
  #
  # La opcion +orden+ permite devolver en un orden determinado los
  # resultados. Es un hash de un solo
  # elemento y puede ser:
  #   :numero => "ASC"
  #   :numero => "DESC"
  #   :fecha_sancion => ...
  #   :fecha_publicacion => ...
  #   :fecha_promulgacion => ...
  #   :creado => ...
  def Norma::buscar_por_fecha(fecha_desde, fecha_hasta, tipo_fecha,
                              otras_opciones = {}, orden = {})
    condstring = "#{tipo_fecha} >= ? AND #{tipo_fecha} <= ?"
    condiciones = [condstring, fecha_desde, fecha_hasta]

    condiciones = Norma.agregar_otras_opciones(condiciones, otras_opciones)

    orden = Norma.agregar_orden(orden)

    Norma.where(condiciones).order(orden).all
  end

  # Busca una serie de normas segun el numero, o segun una parte del numero
  # de la norma
  # Opcionalmente se puede buscar tambien el tipo de norma, el estado y si
  # es particular o general.
  #
  # _Ejemplo:_
  #
  # Para buscar las normas que terminen su numero en "/10" se escribe:
  #
  #   Norma.buscar_por_numero("/10")
  #
  # Para buscar las normas que terminen su numero en "/10" y con estado
  # Vigente(cuyo id es 3):
  #
  #   Norma.buscar_por_numero("/10", {:estado_id => 3})
  #
  # Parametros:
  #   [+:estado_id+]      El id del estado con el cual limitar la busqueda.
  #   [+:tipo_norma_id+]  El id del tipo de norma con el cual limitar la
  #                       busqueda.
  #   [+:general+]        True si buscar normas de tipo general solamente,
  #                       false si buscar solo los particulares. Si no esta
  #                       (o es nil) se buscara tanto particulares como
  #                       generales.
  #
  #
  # La opcion +orden+ permite devolver en un orden determinado los
  # resultados. Es un hash de un solo elemento y puede ser:
  #   :numero => "ASC"
  #   :numero => "DESC"
  #   :fecha_sancion => ...
  #   :fecha_publicacion => ...
  #   :fecha_promulgacion => ...
  #   :creado => ...
  def Norma::buscar_por_numero(numero, otras_opciones = {}, orden = {})
    condstring = 'instr(numero,?)'
    condiciones = [condstring, numero]

    condiciones = Norma.agregar_otras_opciones(condiciones, otras_opciones)
    orden = Norma.agregar_orden(orden)

    Norma.where(condiciones).order(orden).all
  end

  # Busco un texto entre las normas. Puede buscarlo en el texto, en el sumario,
  # las citas doctorales, jurisprudenciales y/o en el comentario.
  #
  # +texto+ es el texto que se va a buscar.
  #
  # +donde+ es donde se va a buscar. Se puede dar varias opciones indicando que
  # se mostraran las normas que posean +texto+ en uno u otro lugar:
  #   [+:texto+]            Devuelve las normas que encuentre +texto+
  #                         en sus textos.
  #   [+:sumario+]          Devuelve las normas que encuentre +texto+
  #                         en sus sumarios.
  #   [+:citas_doctorales+] Devuelve las normas que encuentre +texto+
  #                         en sus citas_doctorales.
  #   [+:cituas_juris+]     Devuelve las normas que encuentre +texto+
  #                         en sus citas jurisprudenciales.
  #   [+:comentario+]       Devuelve las normas que encuentre +texto+
  #                         en sus comentarios.
  #
  # Ejemplo:
  #   Norma.buscar_por_texto("municipio", {:texto => true, :comentario => true})
  #
  # Devuelve todas las normas que posee en la palabra "municipio" en el texto
  # *y/o* en el comentario.
  #
  # La opcion +orden+ permite devolver en un orden determinado
  # los resultados. Es un hash de un solo elemento y puede ser:
  #   :numero => "ASC"
  #   :numero => "DESC"
  #   :fecha_sancion => ...
  #   :fecha_publicacion => ...
  #   :fecha_promulgacion => ...
  #   :creado => ...
  def Norma::buscar_por_texto(texto, donde = {}, otras_opciones = {}, orden = {})
    return [] if donde.empty?

    condstring = ''
    condiciones = [condstring]

    # Tambien eligio buscar en eltexto
    if donde[:texto]
      condstring = "#{condstring} instr(texto,?)"
      condiciones.push(texto)
    end

    # Tambien eligio buscar en el sumario
    if donde[:sumario]
      if condstring.empty?
        condstring = 'instr(sumario, ?)'
      else
        condstring = "#{condstring} OR instr(sumario,?)"
      end
      condiciones.push(texto)
    end

    # Tambien eligio buscar en el citas doctorales
    if donde[:citas_doctorales]
      if condstring.empty?
        condstring = 'instr(citas_doctorales,?)'
      else
        condstring = "#{condstring} OR instr(citas_doctorales,?)"
      end
      condiciones.push(texto)
    end

    # Tambien eligio buscar en el citas jurisprudenciales
    if donde[:citas_juris]
      if condstring.empty?
        condstring = 'instr(citas_jurisprudenciales,?)'
      else
        condstring = "#{condstring} OR instr(citas_jurisprudenciales,?)"
      end
      condiciones.push(texto)
    end

    # Tambien eligio buscar en el comentarios
    if donde[:comentario]
      if condstring.empty?
        condstring = 'instr(comentarios,?)'
      else
        condstring = "#{condstring} OR instr(comentarios,?)"
      end
      condiciones.push(texto)
    end

    condiciones[0] = condstring

    condiciones = Norma.agregar_otras_opciones(condiciones, otras_opciones)

    orden = Norma.agregar_orden(orden)

    Norma.where(condiciones).order(orden).all
  end

  # Busca las normas por descriptor particular o general.
  # Si +desc_part_id+ esta presente, entonces busca las normas que posean
  # ese descriptor particular.
  # Si +desc_part_id+ no esta presente solo busca las que poseen el
  # descriptor general con id +desc_gen_id+.
  #
  # Tambien acepta +otras_opciones+:
  #   [+:estado_id+]      El id del estado con el cual limitar la busqueda.
  #   [+:tipo_norma_id+]  El id del tipo de norma con el cual limitar la
  #                       busqueda.
  #   [+:general+]        True si buscar normas de tipo general solamente,
  #                       false si buscar solo los particulares. Si no esta
  #                       (o es nil) se buscara tanto particulares como
  #                       generales.
  #
  # La opcion +orden+ permite devolver en un orden determinado los
  # resultados. Es un hash de un solo elemento y puede ser:
  #   :numero => "ASC"
  #   :numero => "DESC"
  #   :fecha_sancion => ...
  #   :fecha_publicacion => ...
  #   :fecha_promulgacion => ...
  #   :creado => ...
  def Norma::buscar_por_descriptor(desc_gen_id, desc_part_id = nil,
                                   otras_opciones = {}, orden = {})
    if !(desc_part_id.nil? || desc_part_id.empty?)
      # Eligio un descriptor particular...
      # buscar por descriptor particular solamente.
      condiciones = [
        'descriptor_particular_id = ? AND normas.id = posee_desc_parts.norma_id',
        desc_part_id
      ]

      condiciones = Norma.agregar_otras_opciones(condiciones, otras_opciones)

      orden = Norma.agregar_orden(orden)

      lst_posee_descs = PoseeDescPart.where(condiciones)
                                     .select('posee_desc_parts.*')
                                     .from('normas, posee_desc_parts')
                                     .order(orden)
                                     .all
    else
      # No eligio un desc. particular...
      # buscar por el descriptor general solamente.
      condiciones = [
        'descriptor_general_id = ? AND normas.id = posee_descriptors.norma_id',
        desc_gen_id
      ]

      condiciones = Norma.agregar_otras_opciones(condiciones, otras_opciones)

      orden = Norma.agregar_orden(orden)

      lst_posee_descs = PoseeDescriptor.where(condiciones)
                                       .select('posee_descriptors.*')
                                       .from('normas, posee_descriptors')
                                       .order(orden)
                                       .all
    end

    lst_normas = []
    lst_posee_descs.each do |posee_desc|
      lst_normas.push(posee_desc.norma)
    end

    lst_normas
  end

  # Elimina la norma y <b>todos los registros necesarios</b> en la base de
  # datos.
  # Es necesario porporcionar el id de la misma.
  #   [+norma_id+] El id de la norma a eliminar.
  #
  # *CUIDADO*
  # Esta función eliminará todo:
  #  * la norma
  #  * cualquier relación entre normas y demás entidades:
  #    * Entre la norma y descriptores particulares(_posee_desc_part_).
  #    * Entre la norma y descriptores generales(_posee_descriptor_).
  #    * Entre la norma y Cambios de estados(y sus cambios
  #      aplicados)(_cambio_estado_ y _cambio_aplicado_).
  #    * Entre la norma y la relación con otras normas(_relaciona_con_normas_).
  # No se borrarán descriptores particulares ni generales ni otras normas.
  # Sí se borrarán los cambios de estados y cambios aplicados de los mismos
  # (según lo indica los diagramas MER y los modelos de base de datos
  # realizados).
  #
  def Norma::eliminar_norma(norma_id)
    # Eliminar datos relacionados en posee_desc_part
    PoseeDescPart.eliminar_relaciones_por_norma(norma_id)
    # Eliminar datos relacionados en posee_descriptor
    PoseeDescriptor.eliminar_relaciones_por_norma(norma_id)
    # Eliminar datos en relaciona con normas
    RelacionaConNorma.eliminar_relaciones_por_norma(norma_id)
    # Eliminar datos en cambio_estado
    CambioEstado.eliminar_relaciones_por_norma(norma_id)

    # Borrar la norma
    Norma.delete(norma_id)
  end

end
