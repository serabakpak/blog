class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id]) #params[:id] is passed in the .find method to get the :id parameter from the request
		#instance var used to hold a reference to the article object bc Rails will pass all instance vars to the view
	end

	def new
		@article = Article.new #added this after adding validation bc otherwise @article would be nil in view, and calling @article.errors.any? would throw error
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		# 1) render plain: params[:article].inspect
		#params method - object which rep the parameters (or fields) from form
		
		#saving data in the controller - we need to change the create action to use the new Article model to save data in db
		
		# 2)@article = Article.new(params[:article]) #initialize Rails model with its respective attributes, which are automatically mapped to the respective db columns

		# 3) change to include article_params
		@article = Article.new(article_params)
		#with the validation in place, saving an invalid article will return false, and we need to show the form back 
		if @article.save #save the model in the db
			redirect_to @article #redirect user to the show action --> returns boolean indicating whether article was saved or not
		else
			render 'new' #render used (instead of redirect_to) so that @article object is passed back to the new template when rendered - done w/in same request as form submission (redirect_to will tell browser to issue another request)
		end

	end

	def update #accepts a hash containing the attributes that you want to update
		@article = Article.find(params[:id])
		if @article.update(article_params) #if @article.update(title: 'A new title') was called, only update the title attribute
			redirect_to @article
		else
			render 'edit'
		end
	end	

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end
	#strong parameters - requires us to tell Rails exactly which parameters are allowed into our controller actions (security)
	#have to WHITELIST our controller parameters to prevent wrongful mass assignment
	private #makes sure it can't be called outside its intended context
		def article_params #often factored out into its own method so it can be reused by multiple actions in same controller (e.g. create/update)
			params.require(:article).permit(:title, :text) #we want to both allow and require title and text parameters for valid use of create
		end


end
