class ArticlesController < ApplicationController
	def new

	end

	def create
		# 1) render plain: params[:article].inspect
		#params method - object which rep the parameters (or fields) from form
		
		#saving data in the controller - we need to change the create action to use the new Article model to save data in db
		
		# 2)@article = Article.new(params[:article]) #initialize Rails model with its respective attributes, which are automatically mapped to the respective db columns

		# 3) change to include article_params
		@article = Article.new(article_params)
		@article.save #save the model in the db
		redirect_to @article #redirect user to the show action --> returns boolean indicating whether article was saved or not
		

	end

	#strong parameters - requires us to tell Rails exactly which parameters are allowed into our controller actions (security)
	#have to WHITELIST our controller parameters to prevent wrongful mass assignment
	private #makes sure it can't be called outside its intended context
		def article_params #often factored out into its own method so it can be reused by multiple actions in same controller (e.g. create/update)
			params.require(:article).permit(:title, :text) #we want to both allow and require title and text parameters for valid use of create
		end


end
