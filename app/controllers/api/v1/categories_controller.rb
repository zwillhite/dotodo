module Api
  module V1
    class CategoriesController < ApplicationController
      
      respond_to :json
      
      def index
        
        if params[:ids] == nil
          respond_with Category.all
        else
          haveItems = params[:ids]
          respond_with Category.where('id IN (?)', haveItems)
        end
        
      end
      
    end
  end
end