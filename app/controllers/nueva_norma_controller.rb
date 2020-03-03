# -*- coding: utf-8 -*-

# nueva_norma_controller.rb
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

class NuevaNormaController < ApplicationController

  def index
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end

  #Busca los elementos necesarios para mostrar la página "crear_norma"
  #Finalmente, muestra la página.
  def crear_norma
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.new

      respond_to do |format|
        format.html # new.html.erb
        #format.xml  { render :xml => @norma }
      end
    end
  end

  #Guarad la norma en la base de datos y toma la acción conveniente.
  def guardar_norma
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        #format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.new(params[:norma])
      #@norma.numero = params[:crear_norma][:numero]
      #@norma.sumario = params[:crear_norma][:sumario]
      #@norma.general = params[:crear_norma][:general]
      #@norma.tipo_norma = TipoNorma.find(params[:crear_norma][:tipo_norma_id])
      #@norma.lugar_publicacion =
      #  LugarPublicacion.find(params[:crear_norma][:lugar_publicacion_id])
      #fecha = params[:crear_norma]['fecha_publicacion(1i)'] + "-" +
      #  params[:crear_norma]['fecha_publicacion(2i)'] + "-" +
      # params[:crear_norma]['fecha_publicacion(3i)']
            
      #@norma.fecha_publicacion = fecha

      #fecha = params[:crear_norma]['fecha_sancion(1i)'] + "-" +
      #  params[:crear_norma]['fecha_sancion(2i)'] + "-" +
      #  params[:crear_norma]['fecha_sancion(3i)']
      
      #@norma.fecha_sancion = fecha

      #fecha = params[:crear_norma]['fecha_promulgacion(1i)'] + "-" +
      #  params[:crear_norma]['fecha_promulgacion(2i)'] + "-" +
      #  params[:crear_norma]['fecha_promulgacion(3i)']
      
      #@norma.fecha_promulgacion = fecha
      
      #Asignarle un texto vacío hasta cargarlo, así se guarda en la base.
      @norma.texto = ""
      @norma.comentarios = ""
      @norma.citas_doctorales = ""
      @norma.citas_jurisprudenciales = ""

      if @norma.save
        #Asignarle el estado
        Norma.asignar_estado(
          params[:crear_estado][:estado_id],
          "Estado Inicial - Asignado por el Usuario",
          @norma)
        
        flash[:notice] = '¡Se ha guardado su norma satisfactoriamente!'

        respond_to do |format|
          format.html {redirect_to :action => "agregar_comentarios",
                                   :id => @norma.id}
          #format.xml {head :ok}
        end
      else
        flash[:notice] = '¡Hubo problemas al guardar la norma!'
        respond_to do |format|
          format.html {render :action => "crear_norma"}
          #format.html { render :action => "new" }
          #format.xml  { render :xml => @norma.errors,
          #  :status => :unprocessable_entity }
        end
      end
    end
  end

  def agregar_comentarios
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      @norma = Norma.find(params[:id])

      # Si ya existe un comentario, y no hay privilegios para editar, 
      # entonces rechazarlo.
      if (not @norma.comentarios.nil?) and (@norma.comentarios <=> "") !=  0
        unless verificar_privilegios(Norma::PuedeEditar)
          flash[:notice] = "¡Usted no puede modificar normas!"
          respond_to do |format|
            format.html { redirect_to :controller => "pagina_principal"}
            format.xml { head :ok}
          end
          return
        end
      end

      if params[:modificando].nil?
        @esta_modificando = false
      else
        @esta_modificando = params[:modificando]
      end
      

      respond_to do |format|
        format.html
      end
    end
  end

  def guardar_comentarios
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      @norma = Norma.find(params[:id])

      # Si ya existe un comentario, y no hay privilegios para editar, 
      # entonces rechazarlo.
      if (not @norma.comentarios.nil?) and (@norma.comentarios <=> "") !=  0
        unless verificar_privilegios(Norma::PuedeEditar)
          flash[:notice] = "¡Usted no puede modificar normas!"
          respond_to do |format|
            format.html { redirect_to :controller => "pagina_principal"}
            format.xml { head :ok}
          end
          return
        end
      end

      @norma.comentarios = params[:norma][:comentarios]

      if @norma.save
        flash[:notice] = '¡Se ha guardado los comentarios satisfactoriamente!'

        # Si vino de modificar_norma debe volver allí.
        if params[:modificando].nil? or params[:modificando].to_s == "true"
          respond_to do |format|
            format.html {redirect_to :action => "agregar_citas",
                                     :id => @norma.id}
            format.xml {head :ok}
          end
        else
          #Vino de modificar_norma
          respond_to do |format|
            format.html {redirect_to :controller => "modificar_norma",
                                     :action => "modificar_norma",
                                     :id => @norma}
          end
        end
      else
        flash[:notice] = '¡Hubo problemas al guardar los comentarios!'
        respond_to do |format|
          format.html {render :action => "agregar_comentarios", :id => @norma.id}
          #format.html { render :action => "new" }
          #format.xml  { render :xml => @norma.errors,
          #  :status => :unprocessable_entity }
        end
      end
    end
  end

  def agregar_citas
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      @norma = Norma.find(params[:id])
      @deshabilitar_citas_juris = false
      @deshabilitar_citas_doct = false

      puede_editar = verificar_privilegios(Norma::PuedeEditar)
      # Si ya existe una de las citas, y no hay privilegios para editar,
      # entonces deshabilitar esa cita.
      # Si todas las citas ya existen, entonces, rechazarlo.
      @deshabilitar_citas_juris = ! (
        puede_editar or
        @norma.citas_jurisprudenciales.nil? or
        (@norma.citas_jurisprudenciales.strip == ""))

      # Debe deshabilitar las citas doctorales cuando:
      # La cita no es nil y la cita no es "" y además, no tiene privilegios
      # para editar
      # O sea, si no sucede que:
      # se pueda editar o la cita es nula o tiene "".
      @deshabilitar_citas_doct = ! (
        puede_editar or
        @norma.citas_doctorales.nil? or
        (@norma.citas_doctorales.strip == ""))

      if @deshabilitar_citas_doct and @deshabilitar_citas_juris
        flash[:notice] = "¡Usted no puede modificar normas!"
        respond_to do |format|
          format.html { redirect_to :controller => "pagina_principal"}
          format.xml { head :ok}
        end
        return
      end
  
      if params[:modificando].nil?
        @esta_modificando = false
      else
        @esta_modificando = params[:modificando]
      end

      respond_to do |format|
        format.html
      end
    end
  end

  def guardar_citas
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      @norma = Norma.find(params[:id])

      @deshabilitar_citas_juris = false
      @deshabilitar_citas_doct = false

      puede_editar = verificar_privilegios(Norma::PuedeEditar)
      # Si ya existe una de las citas, y no hay privilegios para editar,
      # entonces deshabilitar esa cita.
      # Si todas las citas ya existen, entonces, rechazarlo.
      @deshabilitar_citas_juris = ! (
        puede_editar or
        @norma.citas_jurisprudenciales.nil? or
        (@norma.citas_jurisprudenciales.strip == ""))
    
      # Debe deshabilitar las citas doctorales cuando:
      # La cita no es nil y la cita no es "" y además, no tiene privilegios
      # para editar
      # O sea, si no sucede que:
      # se pueda editar o la cita es nula o tiene "".
      @deshabilitar_citas_doct = ! (
        puede_editar or
        @norma.citas_doctorales.nil? or
        (@norma.citas_doctorales.strip == ""))


      if @deshabilitar_citas_doct and @deshabilitar_citas_juris
        # No se puede cambiar nada... rechazarlo.
        flash[:notice] = "¡Usted no puede modificar normas!"
        respond_to do |format|
          format.html { redirect_to :controller => "pagina_principal"}
          format.xml { head :ok}
        end
        return
      end

      unless @deshabilitar_citas_doct
        @norma.citas_doctorales = params[:norma][:citas_doctorales]
      end
      unless @deshabilitar_citas_juris
        @norma.citas_jurisprudenciales = params[:norma][:citas_jurisprudenciales]
      end

      if @norma.save
        flash[:notice] = '¡Se ha guardado las citas satisfactoriamente!'

        if params[:modificando].nil? or params[:modificando].to_s == "false"
          respond_to do |format|
            format.html {redirect_to :action => "subir_texto", :id => @norma.id}
            format.xml {head :ok}
          end
        else
          respond_to do |format|
            format.html {redirect_to :controller => "modificar_norma",
                                     :action => "modificar_norma",
                                     :id => @norma}
          end
        end
      else
        flash[:notice] = '¡Hubo problemas al guardar las citas!'
        respond_to do |format|
          format.html {render :action => "agregar_citas", :id => @norma.id}
          #format.html { render :action => "new" }
          #format.xml  { render :xml => @norma.errors,
          #  :status => :unprocessable_entity }
        end
      end
    end
  end

  #Busca los elementos necesarios para mostrar la página "subir_texto".
  #Finalmente, presenta la página.
  def subir_texto
   if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      @norma = Norma.find(params[:id])

      # Si ya hay un texto en la norma(si no es nil y si no es "") y si no
      # tiene privilegios para editar, entonces hay que rechazarlo.
      unless (@norma.texto.nil? or @norma.texto.strip() == "")
        # Hay un texto... ¿tendrá privilegios para cambiarlo?
        unless verificar_privilegios(Norma::PuedeEditar)
          # No... Rechazar
          flash[:notice] = "¡Usted no puede modificar normas!"
          respond_to do |format|
            format.html { redirect_to :controller => "pagina_principal"}
            format.xml { head :ok}
          end
          return
        end
      end
        
      if params[:modificando].nil?
        @esta_modificando = false
      else
        @esta_modificando = params[:modificando]
      end

      respond_to do |format|
          format.html 
          format.xml  { render :xml => @norma,
                               :status => :created,
                               :location => @norma }        
      end
    end
  end

  #Guarda el texto en la base de datos y toma la acción correcta.
  def guardar_texto
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      @norma = Norma.find(params[:id])

      # Si ya hay un texto en la norma(si no es nil y si no es "") y si no
      # tiene privilegios para editar, entonces hay que rechazarlo.
      unless (@norma.texto.nil? or @norma.texto.strip() == "")
        # Hay un texto... ¿tendrá privilegios para cambiarlo?
        unless verificar_privilegios(Norma::PuedeEditar)
          # No... Rechazar
          flash[:notice] = "¡Usted no puede modificar normas!"
          respond_to do |format|
            format.html { redirect_to :controller => "pagina_principal"}
            format.xml { head :ok}
          end
          return
        end
      end

      #DONE: Carga el archivo y lo almacena como texto.
      archivo = params[:norma][:archivoHTML]
      if (not archivo == '') and (archivo.content_type == 'text/html')
        #Hay un archivo que cargar(y es HTML)
        texto = archivo.read
        texto = procesar_texto(texto)
        #flash[:notice] = "texto: #{texto}"
        @norma.texto = texto
      end

      if @norma.save
        #flash[:notice] = '¡Texto almacenado correctamente!'
        #respond_to do |format|
        #    format.html{render_component :controller => "agregar_descriptores",
        #  :action => "seleccionar_desc_gen"}
        #    #format.xml
        #end
        #redirect_to "/agregar_descriptores/seleccionar_desc_gen?id="+params[:id]
        flash[:notice] = "¡Texto almacenado correctamente"

        if params[:modificando].nil? or params[:modificando].to_s == "false"
          respond_to do |format|
            format.html {redirect_to :action => "planificar_vencimientos",
                                     :id => @norma}
          end
        else
          respond_to do |format|
            format.html {redirect_to :controller => "modificar_norma",
                                     :action => "modificar_norma",
                                     :id => @norma}
          end
        end
      else
        flash[:notice] = '¡Problemas al almacenar el texto!'
        respond_to do |format|
            format.html {render :action => "segundo"}
        end
      end
    end
  end

  def planificar_vencimientos
    if not verificar_privilegios(CambioEstado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :action => "crear_relaciones" }
        format.xml { head :ok}
      end
    else
      @cambio_estado = CambioEstado.new
      @norma = Norma.find(params[:id])

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @cambio_estado }
      end
    end
  end

  def planificar
    if not verificar_privilegios(CambioEstado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to(:action => "crear_relaciones")}
        format.xml { head :ok}
      end
    else
      @cambio_estado = CambioEstado.new(params[:cambio_estado])
      @norma = Norma.find(params[:id])
      @cambio_estado.norma =  @norma
      @cambio_estado.fecha_creacion = Time.now.strftime("%Y-%m-%d")

      respond_to do |format|
        if @cambio_estado.save
          flash[:notice] = 'Se ha creado la planificación exitósamente.'
          format.html { redirect_to( :action => "otro_plan", :id => @norma) }
          format.xml  { render :xml => @cambio_estado,
                               :status => :created,
                               :location => @cambio_estado }
        else
          flash[:notice] =
            "¡No se pudo crear la planificación de Cambio de Estado!"
          format.html { redirect_to :action => "planificar_vencimientos",
                                    :id => @norma }
          format.xml  { render :xml => @cambio_estado.errors,
                               :status => :unprocessable_entity }
        end
      end
    end
  end

  def otro_plan
    @norma = Norma.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def crear_relaciones
    if not verificar_privilegios(RelacionaConNorma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to(
         :controller => "agregar_descriptores",
         :action => 'seleccionar_desc_gen',
         :id => params[:id],
         :creando_norma => true)}
        format.xml { head :ok}
      end
    else      
      @norma_inicial = Norma.find(params[:id])
      
      @relaciona_con_norma = RelacionaConNorma.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @relaciona_con_norma }
      end
    end
  end

  def guardar_relacion
     if not verificar_privilegios(RelacionaConNorma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear las relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to(
          :controller => "agregar_descriptores",
          :action => 'seleccionar_desc_gen',
          :id => params[:id],
          :creando_norma => true)}
        format.xml { head :ok}
      end
    else
      @norma_inicial = Norma.find(params[:id])

      @relaciona_con_norma = RelacionaConNorma.new(params[:relaciona_con_norma])
      
      # Sí hubo una norma inicial.
      @relaciona_con_norma.norma_a = @norma_inicial
      
      @relaciona_con_norma.norma_b = Norma.buscar_por_num_ids(
        params[:relacion][:normaB_num],
        params[:relacion][:tipo_normaB])

      #@relaciona_con_norma.tipo_relacion =
      #  TipoRelacion.find(params[:relacion][:tipo_relacion])

      respond_to do |format|
        if @relaciona_con_norma.save
          flash[:notice] = 'Se ha creado la relación exitósamente.'
          format.html {redirect_to :action => 'otra_relacion',
                                   :id => @norma_inicial}
        else
          flash[:notice] = '¡No se pudo crear la relación!'
          format.html { render :action => 'crear_relaciones',
                               :id => @norma_inicial }
          format.xml  { render :xml => @relaciona_con_norma.errors,
                               :status => :unprocessable_entity }
        end
      end
    end
  end

  def otra_relacion
    @norma = Norma.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  protected

  #Procesa el texto del archivo HTML para que no contenga ningún
  #formulario, scripts u otro elemento innecesario que no sea texto
  #con formato.
  def procesar_texto(texto)    
    #Quitamos todos los encabezados
    texto = texto.gsub(/<!DOCTYPE.*<\/head>/mi,'')
    #Quitamos "<body>" y "</body>"
    texto = texto.gsub(/(<body[^>]*>|<\/body>)/mi,'')
    #Quitamos todo "<Form>" que pudisen haber
    texto = texto.gsub(/<form[^>]>.*<\/form>/mi,'')
    #Quitamos los "<% ... %>" y "<%= ... %>" para evitar código ruby
    texto = texto.gsub(/<\%.*\%>/mi,'')
    #Quitamos javascript: "<script> ... </script>"
    texto = texto.gsub(/<script.*<\/script>/mi,'')
    #Quitamos los enters iniciales
    texto = texto.sub(/(\n)*/mi,'')
    #Quitamos enters de más (\n\n... => \n)
    texto = texto.gsub(/\n\n+/,"\n")
    #Quitamos el "</html>" que queda.
    texto = texto.sub(/<\/html>/mi,'')
    
    return texto
  end


end
