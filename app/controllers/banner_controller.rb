# -*- coding: utf-8 -*-

# banner_controller.rb
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


class BannerController < ApplicationController  
  def index

    if session[:current_user_id].nil?
      #No hay login...
      @usuario = nil
      @login = nil
    else
      #Si hay alguien logeado...
      @usuario = Usuario.find session[:current_user_id]
      @login = Login.find_by nombre_usuario: @usuario.nombre
    end    

    respond_to do |format|
      format.html
    end
  end
end
