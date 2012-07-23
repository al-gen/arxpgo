# encoding: utf-8

class BooksController < ApplicationController
  before_filter :authenticate_user!
  # GET /books
  # GET /books.json

  def index

   id_council = getcouncil(params[:council])
   @council =  Council.find(id_council)
   @books =  @council.books.order('num').paginate(:page => params[:page], :per_page => 5) 
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    @council =  Council.find(@book.rada_id)

  end

  # GET /books/new
  # GET /books/new.json
  def new
    id_council = getcouncil(params[:council])
    @council =  Council.find(id_council) 
    
    @page = params[:page]
    @book = @council.books.new
  end

  # GET /books/1/edit
  def edit
    @book =Book.find(params[:id])
    @council = Council.find(@book.rada_id)
  end

  # POST /books
  # POST /books.json
  def create
   id_council = getcouncil(params[:council])
    @council =  Council.find(id_council)     
    
    @page = params[:page]

    @book = @council.books.new(params[:book])

    
      if @book.save then
         redirect_to @book, notice: 'Книга успішно створена' 
        
      else
        render action: "new" 
        
      end

  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])
    @council = Council.find(@book.rada_id)
   
      if @book.update_attributes(params[:book]) then
        redirect_to @book, notice: 'Книга успішно збережена' 
        
      else
         render action: "edit"
       
      end
 
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    id_council = @book.rada_id
    @book.destroy
     redirect_to books_url(:council => id_council) 
  
  end
  
  def selcouncil

    if not params[:Council].nil? then 
     id_council = params[:Council][:id].to_i 

    end
    redirect_to :action => "index",  :council => id_council

  end
  
  def gobook
    id_book = params[:id]
    
    redirect_to :action => "index", :controller => "pgos", :book => id_book, :council => Book.find(id_book).rada_id 
  end
  
end
