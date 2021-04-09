# coding: utf-8
module ApplicationHelper

  # Devuelve todos los estados de una norma ordenados según el nombre.
  #
  def get_estados
    @estados = Estado.all.order :nombre
  end

  # Devuelve todas las causas de cambios de estados ordenados según el nombre.
  #
  def get_causa_cambio_estados
    @causas = CausaCambioEstado.all.order :nombre
  end

  # Devuelve todos los tipos de normas ordenados según el nombre
  #
  def get_tipos_norma
    @tipos_norma = TipoNorma.all.order :nombre
  end

  # Devuevle todos los lugares de publicación ordenados según el nombre.
  #
  def get_lugares_publicacion
    @lugares_publicacion = LugarPublicacion.all.order :nombre
  end

  # Devuelve una colección de todos los patrones de privilegios que hay.
  # Se devolverán ordenados según el nombre.
  def get_patrones_privilegios
    return PatronPrivilegio.find.all.order :nombre
  end

  # Devuelve una colección de todos los privilegios ordenados según el nombre
  #
  def get_privilegios
    return Privilegio.find.all.order :nombre
  end

  # Devuelve todos los nombres de usuarios ordenados alfabéticamente.
  #
  def get_usuarios
    return Usuario.all.order :nombre
  end

  # Devuelve los tipos de las relaciones de normas ordenados según
  # el nombre.
  #
  def get_tipo_relaciones
    return TipoRelacion.all.order :nombre
  end
end
