# -*- coding: utf-8 -*-

# buscar_por_texto_controller.rb
# Copyright (C) 2010  Giménez, Christian N.

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

class BuscarPorTextoController < ApplicationController

  def index
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end

  ##
  # Cambia el texto a HTML para que la búsqueda con acentos y símbolos
  # españoles esa exacta.
  # (Supóngase que si usted quiere buscar "el año pasado aún", tanto
  # como la "año" como "aún" no serán encontradas en la base de datos
  # porque están guardadas como "a&ntilde;o" y "a&uacute;n").
  def transformar_html(texto)
    texto = texto.gsub("á","&aacute;")
    texto = texto.gsub("é","&eacute;")
    texto = texto.gsub("í","&iacute;")
    texto = texto.gsub("ó","&oacute;")
    texto = texto.gsub("ú","&uacute;")
    texto = texto.gsub("Á","&Aacute;")
    texto = texto.gsub("É","&Eacute;")
    texto = texto.gsub("Í","&Iacute;")
    texto = texto.gsub("Ó","&Oacute;")
    texto = texto.gsub("Ú","&Uacute;")
    texto = texto.gsub("ñ","&ntilde;")
    texto = texto.gsub("Ñ","&Ntilde;")
    texto = texto.gsub("°","&deg;")
    texto = texto.gsub("Ç","&Ccedil;")
    texto = texto.gsub("ç","&ccedil;")
    texto = texto.gsub("ü","&uuml;")
    return texto
  end

  def buscar_texto
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else

      if params[:buscar_texto][:texto] == ''
        #No hay un texto para buscar(Ingresó "")
        flash[:notice] = '¡Escriba un texto a buscar!'

        respond_to do |format|
          format.html {render :action => 'index'}
        end
        return
      end


      texto = params[:buscar_texto][:texto]
      donde = Hash.new
      otras_opciones = Hash.new

      if params[:buscar_texto][:buscar_en_texto] == '1'
        donde[:texto] = true
      end

      if params[:buscar_texto][:buscar_en_sumario] == '1'
        donde[:sumario] = true
      end

      if params[:buscar_texto][:buscar_en_citas_doctorales] == '1'
        donde[:citas_doctorales] = true
      end

      if params[:buscar_texto][:buscar_en_citas_jurisprudenciales] == '1'
        donde[:citas_juris] = true
      end

      if params[:buscar_texto][:buscar_en_comentarios] == '1'
        donde[:comentario] = true
      end


      if params[:buscar_texto][:estado_todos] == '1'
        #Selecciono un estado.
        otras_opciones[:estado_id] =params[:buscar_texto][:estado_id]
      end

      if params[:buscar_texto][:tipo_norma_todos] == '1'
        #Seleccionó un tipo de norma en particular.
        otras_opciones[:tipo_norma_id] = params[:buscar_texto][:tipo_norma_id]
      end

      if params[:buscar_texto][:general_particular] == "Generales"
        #Eligió buscar los que sean generales
        otras_opciones[:general] = true
      end

      if params[:buscar_texto][:general_particular] == "Particulares"
        #Eligió buscar los que sean particulares
        otras_opciones[:general] = false
      end

      # Orden en que se imprimen los resultados
      orden = armar_orden(params[:buscar_texto])

      @lstNormas = Norma.buscar_por_texto(texto, donde, otras_opciones, orden)

      respond_to do |format|
        format.html {render :action => "resultados"}
      end
    end
  end

  ##
  # Vista impresión del resultado de la búsqueda.
  def vista_impresion
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else

      if params[:buscar_texto][:texto] == ''
        #No hay un texto para buscar(Ingresó "")
        flash[:notice] = '¡Escriba un texto a buscar!'

        respond_to do |format|
          format.html {render :action => 'index'}
        end
        return
      end


      texto = params[:buscar_texto][:texto]
      texto = transformar_html(texto)
      donde = Hash.new
      otras_opciones = Hash.new

      if params[:buscar_texto][:buscar_en_texto] == '1'
        donde[:texto] = true
      end

      if params[:buscar_texto][:buscar_en_sumario] == '1'
        donde[:sumario] = true
      end

      if params[:buscar_texto][:buscar_en_citas_doctorales] == '1'
        donde[:citas_doctorales] = true
      end

      if params[:buscar_texto][:buscar_en_citas_jurisprudenciales] == '1'
        donde[:citas_juris] = true
      end

      if params[:buscar_texto][:buscar_en_comentarios] == '1'
        donde[:comentario] = true
      end


      if params[:buscar_texto][:estado_todos] == '1'
        #Selecciono un estado.
        otras_opciones[:estado_id] =params[:buscar_texto][:estado_id]
      end

      if params[:buscar_texto][:tipo_norma_todos] == '1'
        #Seleccionó un tipo de norma en particular.
        otras_opciones[:tipo_norma_id] = params[:buscar_texto][:tipo_norma_id]
      end

      if params[:buscar_texto][:general_particular] == "Generales"
        #Eligió buscar los que sean generales
        otras_opciones[:general] = true
      end

      if params[:buscar_texto][:general_particular] == "Particulares"
        #Eligió buscar los que sean particulares
        otras_opciones[:general] = false
      end


      # Orden en que se imprimen los resultados
      orden = armar_orden(params[:buscar_texto])

      @lstNormas = Norma.buscar_por_texto(texto, donde, otras_opciones, orden)

      respond_to do |format|
        format.html {render :layout => "resultados_amigable_impresion"}
      end
    end
  end


end
