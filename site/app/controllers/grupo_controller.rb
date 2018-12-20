class GrupoController < ApplicationController

	#TODO: todas as checageens de grupo, creio que o model já ta todo ok


	def getUser(idUser)
        begin
            user = User.find(idUser)
        rescue ActiveRecord::RecordNotFound
            return nil
        end
    end


	def index
		# @grupos = Grupo.search(params[:search]) #Para buscar por nome
		@grupos = Grupo.all
	end

	def new
		@grupo = Grupo.new
	end

	def show
	end

	def edit
	end

	def create
		@grupo = Grupo.new(grupo_params)
		respond_to do |format|
			if @grupo.save
				format.html { redirect_to grupos_url, notice: 'Grupo was successfully created.' }
			else
				format.html { render :new }
			end
		end
		@grupo.addUser(current_user)
	end

	def update
		respond_to do |format|
			if @grupo.update(grupo_params)
				format.html { redirect_to  grupos_url, notice: 'Grupo was successfully updated.' }
			else
				format.html { render :edit }
			end
		end
	end


	def destroy
		@grupo.destroy
		respond_to do |format|
			format.html { redirect_to '/home', notice: 'Grupo was successfully destroyed.' }
		end
	end

	def gruposDe()
		todosGrupos = Grupo.all
		@grupos = Array.new
		todosGrupos.each do |g|
			if(g.getUsers().include?(getUser(params[:id])))
		 		@grupos.push(g) #append
			end
		end
		render "grupo/index"
	end


	private
	def grupo_params
		params.require(:grupo).permit(:nome, :descricao)
	end

end
